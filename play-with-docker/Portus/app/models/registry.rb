# == Schema Information
#
# Table name: registries
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  hostname          :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  use_ssl           :boolean
#  external_hostname :string(255)
#
# Indexes
#
#  index_registries_on_hostname  (hostname) UNIQUE
#  index_registries_on_name      (name) UNIQUE
#

# Registry holds data regarding the registries registered in the Portus
# application.
#
# NOTE: currently only one Registry is allowed to exist in the database. This
# might change in the future.
class Registry < ActiveRecord::Base
  has_many :namespaces

  validates :name, presence: true, uniqueness: true
  validates :hostname, presence: true, uniqueness: true
  validates :external_hostname, presence: false
  validates :use_ssl, inclusion: [true, false]

  # On create, make sure that all the needed namespaces are in place.
  after_create :create_namespaces!

  # Today the data model supports many registries
  # however Portus just supports on Registry
  # therefore to avoid confusion, define just one way
  # to ask for the registy
  def self.get
    Registry.first
  end

  # Finds the registry with the given hostname. It first looks for the
  # `hostname` column, and then it fallbacks to `external_hostname`.
  def self.find_by_hostname(hostname)
    registry = Registry.find_by(hostname: hostname)
    if registry.nil?
      Rails.logger.debug("No hostname matching `#{hostname}', testing external_hostname")
      registry = Registry.find_by(external_hostname: hostname)
    end
    registry
  end

  # Returns the global namespace owned by this registry.
  def global_namespace
    Namespace.find_by(registry: self, global: true)
  end

  # Returns a registry client based on this registry that authenticates with
  # the credentials of the "portus" user.
  def client
    Portus::RegistryClient.new(hostname, use_ssl)
  end

  # Find the registry for the given push event.
  def self.find_from_event(event)
    request_hostname = event["request"]["host"]
    registry = Registry.find_by(hostname: request_hostname)
    if registry.nil?
      logger.debug("No hostname matching #{request_hostname}, testing external_hostname")
      registry = Registry.find_by(external_hostname: request_hostname)
    end
    if registry.nil?
      logger.info("Ignoring event coming from unknown registry #{request_hostname}")
    end
    registry
  end

  # Fetch the information regarding a namespace on this registry for the given
  # event. If no namespace was found, then it returns nil. Otherwise, it
  # returns three values:
  #   - A Namespace object.
  #   - A String containing the name of the repository.
  #   - A String containing the name of the tag or nil if the `fetch_tag`
  #     parameter has been set to false.
  def get_namespace_from_event(event, fetch_tag = true)
    repo = event["target"]["repository"]
    if repo.include?("/")
      namespace_name, repo = repo.split("/", 2)
      namespace = namespaces.find_by(name: namespace_name)
    else
      namespace = global_namespace
    end

    if namespace.nil?
      logger.error "Cannot find namespace #{namespace_name} under registry #{hostname}"
      return
    end

    if fetch_tag
      tag_name = get_tag_from_target(namespace, repo, event["target"])
      return if tag_name.nil?
    else
      tag_name = nil
    end

    [namespace, repo, tag_name]
  end

  # Checks whether this registry is reachable. If it is, then an empty string
  # is returned. Otherwise a string will be returned containing the reasoning
  # of the reachability failure.
  def reachable?
    msg = ""

    # rubocop:disable Lint/ShadowedException:
    begin
      r = client.reachable?

      # At this point, !r is only possible if the returned code is 404, which
      # according to the documentation we have to assume that the registry is
      # not implementing the v2 of the API.
      return "Error: registry does not implement v2 of the API." unless r
    rescue Errno::ECONNREFUSED, SocketError
      msg = "Error: connection refused. The given registry is not available!"
    rescue Errno::ETIMEDOUT, Net::OpenTimeout
      msg = "Error: connection timed out. The given registry is not available!"
    rescue Net::HTTPBadResponse
      msg = if use_ssl
        "Error: there's something wrong with your SSL configuration."
      else
        "Error: not using SSL, but the given registry does use SSL."
      end
    rescue OpenSSL::SSL::SSLError => e
      msg = "SSL error while communicating with the registry, check the server " \
        "logs for more details."
      logger.error(e)
    rescue StandardError => e
      # We don't know what went wrong :/
      logger.info "Registry not reachable: #{e.inspect}"
      msg = "Error: something went wrong. Check your configuration."
    end
    # rubocop:enable Lint/ShadowedException:
    msg
  end

  protected

  # Fetch the tag being pushed through the given target object.
  def get_tag_from_target(namespace, repo, target)
    # Since Docker Distribution 2.4 the registry finally sends the tag, so we
    # don't have to perform requests afterwards.
    return target["tag"] unless target["tag"].blank?

    # Tough luck, we should now perform requests to fetch the tag. Note that
    # depending on the Manifest version we have to do one thing or another
    # because they expose different information.
    case target["mediaType"]
    when "application/vnd.docker.distribution.manifest.v1+json",
      "application/vnd.docker.distribution.manifest.v1+prettyjws"
      get_tag_from_manifest(target)
    when "application/vnd.docker.distribution.manifest.v2+json",
      "application/vnd.docker.distribution.manifest.list.v2+json"
      get_tag_from_list(namespace, repo)
    else
      raise "unsupported media type \"#{target["mediaType"]}\""
    end

  rescue StandardError => e
    logger.info("Could not fetch the tag for target #{target}")
    logger.info("Reason: #{e.message}")
    nil
  end

  # Fetch the tag by making the difference of what we've go on the DB, and
  # what's available on the registry. Returns a string with the tag on success,
  # otherwise it returns nil.
  def get_tag_from_list(namespace, repository)
    full_repo_name = namespace.global? ? repository : "#{namespace.name}/#{repository}"
    tags = client.tags(full_repo_name)
    return if tags.nil?

    repo = Repository.find_by(name: repository, namespace: namespace)
    return tags.first if repo.nil?
    resulting = tags - repo.tags.pluck(:name)

    # Note that it might happen that there are multiple tags not yet in sync
    # with Portus' DB. This means that the registry might have been
    # unresponsive for a long time. In this case, it's not such a problem to
    # pick up the first label, and wait for the CatalogJob to update the
    # rest.
    resulting.first
  end

  # Fetch the tag of the image contained in the current event. The Manifest API
  # is used to fetch it, thus the repo name and the digest are needed (and
  # they are contained inside the event's target).
  #
  # Returns the name of the tag if found, nil otherwise.
  def get_tag_from_manifest(target)
    _, _, manifest = client.manifest(target["repository"], target["digest"])
    manifest["tag"]
  end

  # Create the global namespace for this registry and create the personal
  # namespace for all the existing users.
  def create_namespaces!
    count = Registry.count

    # Create the global team/namespace.
    team = Team.create(
      name:   "portus_global_team_#{count}",
      owners: User.where(admin: true),
      hidden: true
    )
    Namespace.create!(
      name:        "portus_global_namespace_#{count}",
      registry:    self,
      visibility:  Namespace.visibilities[:visibility_public],
      global:      true,
      description: "The global namespace for the registry #{Registry.name}.",
      team:        team
    )

    # TODO: change code once we support multiple registries
    User.find_each(&:create_personal_namespace!)
  end
end
