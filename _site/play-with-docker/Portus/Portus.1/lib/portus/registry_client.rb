module Portus
  # RegistryClient is a a layer between Portus and the Registry. Given a set of
  # credentials, it's able to call to any endpoint in the registry API. Moreover,
  # it also implements some handy methods on top of some of these endpoints (e.g.
  # the `manifest` method for the Manifest API endpoints).
  class RegistryClient
    include HttpHelpers

    # Exception being raised when we get an error from the Registry API that we
    # don't know how to handle.
    class RegistryError < StandardError; end

    # Initialize the client by setting up a hostname and the user. Note that if
    # no user was given, the "portus" special user is assumed.
    def initialize(host, use_ssl = false, username = nil, password = nil)
      @host     = host
      @use_ssl  = use_ssl
      @base_url = "http#{"s" if @use_ssl}://#{@host}/v2/"
      @username = username || "portus"
      @password = password || Rails.application.secrets.portus_password
    end

    # Returns whether the registry is reachable with the given credentials or
    # not.
    def reachable?
      res = perform_request("", "get", false)

      # If a 401 was retrieved, it means that at least the registry has been
      # contacted. In order to get a 200, this registry should be created and
      # an authorization requested. The former can be inconvenient, because we
      # might want to test whether the registry is reachable.
      !res.nil? && res.code.to_i == 401
    end

    # Calls the `/:repository/manifests/:tag` endpoint from the registry. It
    # returns a three-sized array:
    #
    #   - The image ID (without the "sha256:" prefix): only available for v2
    #     manifests (nil if v1).
    #   - The manifest digest.
    #   - The manifest itself as a ruby hash.
    #
    # It will raise either a ManifestNotFoundError or a RuntimeError if
    # something goes wrong.
    def manifest(repository, tag = "latest")
      res = perform_request("#{repository}/manifests/#{tag}", "get")

      if res.code.to_i == 200
        mf = JSON.parse(res.body)
        id = mf.try(:[], "config").try(:[], "digest")
        id = id.split(":").last if id.is_a? String
        digest = res["Docker-Content-Digest"]
        [id, digest, mf]
      elsif res.code.to_i == 404
        handle_error res, repository: repository, tag: tag
      else
        raise "Something went wrong while fetching manifest for " \
          "#{repository}:#{tag}:[#{res.code}] - #{res.body}"
      end
    end

    # Fetches all the repositories available in the registry, with all their
    # corresponding tags. If something goes wrong while fetching the repos from
    # the catalog (e.g. authorization error), it will raise an exception.
    #
    # Returns an array of hashes which contain two keys:
    #   - name: a string containing the name of the repository.
    #   - tags: an array containing the available tags for the repository.
    def catalog
      res = paged_response("_catalog", "repositories")
      add_tags(res)
    end

    # Returns an array containing the list of tags. If something goes wrong,
    # then it raises an exception.
    def tags(repository)
      paged_response("#{repository}/tags/list", "tags")
    end

    # Deletes a blob/manifest of the specified image. Returns true if the
    # request was successful, otherwise it raises an exception.
    def delete(name, digest, object = "blobs")
      res = perform_request("#{name}/#{object}/#{digest}", "delete")
      if res.code.to_i == 202
        true
      elsif res.code.to_i == 404 || res.code.to_i == 405
        handle_error res, name: name, digest: digest
      else
        raise ::Portus::RegistryClient::RegistryError,
          "Something went wrong while deleting blob: " \
          "[#{res.code}] - #{res.body}"
      end
    end

    protected

    # Returns all the items that could be extracted from the given link that
    # are indexed by the given field in a successful response. If anything goes
    # wrong, it raises an exception.
    def paged_response(link, field)
      res = []
      link += "?n=#{APP_CONFIG["registry"]["catalog_page"]["value"]}"

      until link.empty?
        page, link = get_page(link)
        next unless page[field]
        res += page[field]
      end
      res
    end

    # Fetches the next page from the provided link. On success, it will return
    # an array of the items:
    #   - The parsed response body.
    #   - The link to the next page.
    # On error it will raise the proper exception.
    def get_page(link)
      res = perform_request(link)
      if res.code.to_i == 200
        [JSON.parse(res.body), fetch_link(res["link"])]
      elsif res.code.to_i == 404
        handle_error res
      else
        raise ::Portus::RegistryClient::RegistryError,
          "Something went wrong while fetching the catalog " \
          "Response: [#{res.code}] - #{res.body}"
      end
    end

    # Fetch the link to the next catalog page from the given response.
    def fetch_link(header)
      return "" if header.blank?
      link = header.split(";")[0]
      link.strip[1, link.size - 2]
    end

    # Adds the available tags for each of the given repositories. If there is a
    # problem while fetching a repository's tag, it will return an empty array.
    # Otherwise it will return an array with the results as specified in the
    # documentation of the `catalog` method.
    def add_tags(repositories)
      return [] if repositories.nil?

      result = []
      repositories.each do |repo|
        begin
          ts = tags(repo)
          result << { "name" => repo, "tags" => ts } unless ts.blank?
        rescue StandardError => e
          Rails.logger.debug "Could not get tags for repo: #{repo}: #{e.message}."
        end
      end
      result
    end
  end
end
