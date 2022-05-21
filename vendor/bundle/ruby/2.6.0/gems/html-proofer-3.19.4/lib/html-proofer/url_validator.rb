# frozen_string_literal: true

require 'typhoeus'
require 'uri'
require_relative './utils'
require_relative './cache'

module HTMLProofer
  class UrlValidator
    include HTMLProofer::Utils

    attr_reader :external_urls
    attr_writer :before_request

    def initialize(logger, cache, external_urls, options)
      @logger = logger
      @external_urls = external_urls
      @failed_tests = []
      @options = options
      @hydra = Typhoeus::Hydra.new(@options[:hydra])
      @cache = cache
      @before_request = []
    end

    def run
      @external_urls = remove_query_values

      if @cache.use_cache?
        urls_to_check = @cache.retrieve_urls(@external_urls, :external)
        external_link_checker(urls_to_check)
        @cache.write
      else
        external_link_checker(@external_urls)
      end

      @failed_tests
    end

    def remove_query_values
      return nil if @external_urls.nil?

      paths_with_queries = {}
      iterable_external_urls = @external_urls.dup
      @external_urls.each_key do |url|
        uri = begin
          Addressable::URI.parse(url)
        rescue URI::Error, Addressable::URI::InvalidURIError
          @logger.log :error, "#{url} is an invalid URL"
          nil
        end
        next if uri.nil? || uri.query.nil?

        iterable_external_urls.delete(url) unless new_url_query_values?(uri, paths_with_queries)
      end
      iterable_external_urls
    end

    # remember queries we've seen, ignore future ones
    def new_url_query_values?(uri, paths_with_queries)
      queries = uri.query_values.keys.join('-')
      domain_path = extract_domain_path(uri)
      if paths_with_queries[domain_path].nil?
        paths_with_queries[domain_path] = [queries]
        true
      elsif !paths_with_queries[domain_path].include?(queries)
        paths_with_queries[domain_path] << queries
        true
      else
        false
      end
    end

    def extract_domain_path(uri)
      uri.host + uri.path
    end

    # Proofer runs faster if we pull out all the external URLs and run the checks
    # at the end. Otherwise, we're halting the consuming process for every file during
    # `process_files`.
    #
    # In addition, sorting the list lets libcurl keep connections to the same hosts alive.
    #
    # Finally, we'll first make a HEAD request, rather than GETing all the contents.
    # If the HEAD fails, we'll fall back to GET, as some servers are not configured
    # for HEAD. If we've decided to check for hashes, we must do a GET--HEAD is
    # not available as an option.
    def external_link_checker(external_urls)
      external_urls = external_urls.sort.to_h

      count = external_urls.length
      check_text = pluralize(count, 'external link', 'external links')
      @logger.log :info, "Checking #{check_text}..."

      # Route log from Typhoeus/Ethon to our own logger
      Ethon.logger = @logger

      establish_queue(external_urls)

      @hydra.run
    end

    def establish_queue(external_urls)
      external_urls.each_pair do |url, filenames|
        url = begin
          clean_url(url)
        rescue URI::Error, Addressable::URI::InvalidURIError
          add_external_issue(filenames, "#{url} is an invalid URL")
          next
        end

        method = if hash?(url) && @options[:check_external_hash]
                   :get
                 else
                   :head
                 end
        queue_request(method, url, filenames)
      end
    end

    def clean_url(href)
      # catch any obvious issues, like strings in port numbers
      parsed = Addressable::URI.parse(href)
      if href =~ /^([!#{Regexp.last_match(0)}-;=?-\[\]_a-z~]|%[0-9a-fA-F]{2})+$/
        href
      else
        parsed.normalize
      end
    end

    def queue_request(method, href, filenames)
      opts = @options[:typhoeus].merge(method: method)
      request = Typhoeus::Request.new(href, opts)
      @before_request.each do |callback|
        callback.call(request)
      end
      request.on_complete { |response| response_handler(response, filenames) }
      @hydra.queue request
    end

    def response_handler(response, filenames)
      effective_url = response.options[:effective_url]
      href = response.request.base_url.to_s
      method = response.request.options[:method]
      response_code = response.code
      response.body.delete!("\x00")

      debug_msg = if filenames.nil?
                    "Received a #{response_code} for #{href}"
                  else
                    "Received a #{response_code} for #{href}  in #{filenames.join(' ')}"
                  end

      @logger.log :debug, debug_msg

      return if @options[:http_status_ignore].include?(response_code)

      if response_code.between?(200, 299)
        @cache.add(href, filenames, response_code) unless check_hash_in_2xx_response(href, effective_url, response, filenames)
      elsif response.timed_out?
        handle_timeout(href, filenames, response_code)
      elsif response_code.zero?
        handle_failure(effective_url, filenames, response_code, response.return_message)
      elsif method == :head
        queue_request(:get, href, filenames)
      else
        return if @options[:only_4xx] && !response_code.between?(400, 499)

        # Received a non-successful http response.
        msg = "External link #{href} failed: #{response_code} #{response.return_message}"
        add_external_issue(filenames, msg, response_code)
        @cache.add(href, filenames, response_code, msg)
      end
    end

    # Even though the response was a success, we may have been asked to check
    # if the hash on the URL exists on the page
    def check_hash_in_2xx_response(href, effective_url, response, filenames)
      return false if @options[:only_4xx]
      return false unless @options[:check_external_hash]
      return false unless (hash = hash?(href))

      body_doc = create_nokogiri(response.body)

      unencoded_hash = Addressable::URI.unescape(hash)
      xpath = [%(//*[@name="#{hash}"]|/*[@name="#{unencoded_hash}"]|//*[@id="#{hash}"]|//*[@id="#{unencoded_hash}"])]
      # user-content is a special addition by GitHub.
      if URI.parse(href).host =~ /github\.com/i
        xpath << [%(//*[@name="user-content-#{hash}"]|//*[@id="user-content-#{hash}"])]
        # when linking to a file on GitHub, like #L12-L34, only the first "L" portion
        # will be identified as a linkable portion
        xpath << [%(//td[@id="#{Regexp.last_match[1]}"])] if hash =~ /\A(L\d)+/
      end

      return unless body_doc.xpath(xpath.join('|')).empty?

      msg = "External link #{href} failed: #{effective_url} exists, but the hash '#{hash}' does not"
      add_external_issue(filenames, msg, response.code)
      @cache.add(href, filenames, response.code, msg)
      true
    end

    def handle_timeout(href, filenames, response_code)
      msg = "External link #{href} failed: got a time out (response code #{response_code})"
      @cache.add(href, filenames, 0, msg)
      return if @options[:only_4xx]

      add_external_issue(filenames, msg, response_code)
    end

    def handle_failure(href, filenames, response_code, return_message)
      msg = "External link #{href} failed: response code #{response_code} means something's wrong.
             It's possible libcurl couldn't connect to the server or perhaps the request timed out.
             Sometimes, making too many requests at once also breaks things.
             Either way, the return message (if any) from the server is: #{return_message}"
      @cache.add(href, filenames, 0, msg)
      return if @options[:only_4xx]

      add_external_issue(filenames, msg, response_code)
    end

    def add_external_issue(filenames, desc, status = nil)
      # possible if we're checking an array of links
      if filenames.nil?
        @failed_tests << Issue.new('', desc, status: status)
      else
        filenames.each { |f| @failed_tests << Issue.new(f, desc, status: status) }
      end
    end

    # Does the URL have a hash?
    def hash?(url)
      URI.parse(url).fragment
    rescue URI::InvalidURIError
      false
    end
  end
end
