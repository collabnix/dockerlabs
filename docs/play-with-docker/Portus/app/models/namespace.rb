# == Schema Information
#
# Table name: namespaces
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  team_id     :integer
#  registry_id :integer          not null
#  global      :boolean          default("0")
#  description :text(65535)
#  visibility  :integer
#
# Indexes
#
#  fulltext_index_namespaces_on_name         (name)
#  index_namespaces_on_name_and_registry_id  (name,registry_id) UNIQUE
#  index_namespaces_on_registry_id           (registry_id)
#  index_namespaces_on_team_id               (team_id)
#

class Namespace < ActiveRecord::Base
  include PublicActivity::Common
  include SearchCop

  search_scope :search do
    attributes :name, :description
  end

  # This regexp is extracted from the reference package of Docker Distribution
  # and it matches a valid namespace name.
  NAME_REGEXP = /\A[a-z0-9]+(?:[._\\-][a-z0-9]+)*\Z/

  # The maximum length of a namespace name.
  MAX_NAME_LENGTH = 255

  has_many :webhooks
  has_many :repositories
  belongs_to :registry
  belongs_to :team

  enum visibility: [:visibility_private, :visibility_protected, :visibility_public]

  validate :global_namespace_cannot_be_private
  validates :name,
            presence:   true,
            uniqueness: { scope: "registry_id" },
            length:     { maximum: MAX_NAME_LENGTH },
            namespace:  true

  scope :not_portus, -> { where.not name: "portus" }

  # Returns true if this namespace belongs to the internal user "portus".
  def portus?
    name == "portus"
  end

  # global_namespace_cannot_be_private adds an error and returns false if the
  # visibility of the global namespace is set to private. Otherwise, it returns
  # true. This function is used to validate the visibility.
  def global_namespace_cannot_be_private
    if global? && visibility_private?
      errors.add(:visibility, "global namespace cannot be private")
      return false
    end
    true
  end

  # From the given repository name that can be prefix by the name of the
  # namespace, returns two values:
  #   1. The namespace where the given repository belongs to.
  #   2. The name of the repository itself.
  # If a registry is provided, it will query it for the given repository name.
  def self.get_from_name(name, registry = nil)
    if name.include?("/")
      namespace, name = name.split("/", 2)
      namespace = if registry.nil?
        Namespace.find_by(name: namespace)
      else
        registry.namespaces.find_by(name: namespace)
      end
    else
      namespace = if registry.nil?
        Namespace.find_by(global: true)
      else
        Namespace.find_by(registry: registry, global: true)
      end
    end
    [namespace, name, registry]
  end

  # Tries to transform the given name to a valid namespace name. If the name is
  # already valid, then it's returned untouched. Otherwise, if the name cannot
  # be turned into a valid namespace name, then nil is returned.
  def self.make_valid(name)
    return name if name =~ NAME_REGEXP

    # One common case is LDAP and case sensitivity. With this in mind, try to
    # downcase everything and see if now it's fine.
    name = name.downcase
    return name if name =~ NAME_REGEXP

    # Let's strip extra characters from the beginning and end.
    first = name.index(/[a-z0-9]/)
    return nil if first.nil?
    last = name.rindex(/[a-z0-9]/)
    str = name[first..last]

    # Replace weird characters with underscores.
    str = str.gsub(/[^[a-z0-9\\.\\-_]]/, "_")

    # Only one special character is allowed in between of alphanumeric
    # characters. Thus, let's merge multiple appearences into one on each case.
    # After that, the name should be fine, so let's trim it if it's too large.
    final = str.gsub(/[._\\-]{2,}/, "_")
    name = final[0..MAX_NAME_LENGTH]

    return nil if name !~ NAME_REGEXP
    name
  end

  # Returns a String containing the cleaned name for this namespace. The
  # cleaned name will be the registry's hostname if this is a global namespace,
  # or the name of the namespace itself otherwise.
  def clean_name
    global? ? registry.hostname : name
  end
end
