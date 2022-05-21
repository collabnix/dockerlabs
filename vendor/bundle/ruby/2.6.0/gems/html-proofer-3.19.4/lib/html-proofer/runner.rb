# frozen_string_literal: true

module HTMLProofer
  class Runner
    include HTMLProofer::Utils

    attr_reader :options, :internal_urls, :external_urls, :failures

    def initialize(src, opts = {})
      @src = src

      @options = HTMLProofer::Configuration::PROOFER_DEFAULTS.merge(opts)

      @options[:typhoeus] = HTMLProofer::Configuration::TYPHOEUS_DEFAULTS.merge(opts[:typhoeus] || {})
      @options[:hydra] = HTMLProofer::Configuration::HYDRA_DEFAULTS.merge(opts[:hydra] || {})

      @options[:parallel] = HTMLProofer::Configuration::PARALLEL_DEFAULTS.merge(opts[:parallel] || {})
      @options[:validation] = HTMLProofer::Configuration::VALIDATION_DEFAULTS.merge(opts[:validation] || {})
      @options[:cache] = HTMLProofer::Configuration::CACHE_DEFAULTS.merge(opts[:cache] || {})

      @type = @options.delete(:type)
      @logger = HTMLProofer::Log.new(@options[:log_level])
      @cache = Cache.new(@logger, @options[:cache])
      @internal_link_checks = nil

      # Add swap patterns for internal domains
      unless @options[:internal_domains].empty?
        @options[:internal_domains].each do |dom|
          @options[:url_swap][Regexp.new("^http://#{dom}")] = ''
          @options[:url_swap][Regexp.new("^https://#{dom}")] = ''
          @options[:url_swap][Regexp.new("^//#{dom}")] = ''
        end
      end

      @internal_urls = {}
      @internal_urls_to_paths = {}
      @external_urls = {}
      @failures = []
      @before_request = []
    end

    def run
      if @type == :links
        @logger.log :info, "Running #{checks} on #{@src}... \n\n"
        check_list_of_links unless @options[:disable_external]
      else
        @logger.log :info, "Running #{checks} on #{@src} on *#{@options[:extension]}... \n\n"
        check_files
        file_text = pluralize(files.length, 'file', 'files')
        @logger.log :info, "Ran on #{file_text}!\n\n"
      end

      if @failures.empty?
        @logger.log :info, 'HTML-Proofer finished successfully.'
      else
        @failures.uniq!
        print_failed_tests
      end
    end

    def check_list_of_links
      if @options[:url_swap]
        @src = @src.map do |url|
          swap(url, @options[:url_swap])
        end
      end
      @external_urls = @src.each_with_object({}) do |url, hash|
        hash[url] = nil
      end
      validate_external_urls
    end

    # Collects any external URLs found in a directory of files. Also collectes
    # every failed test from process_files.
    # Sends the external URLs to Typhoeus for batch processing.
    def check_files
      process_files.each do |item|
        @external_urls.merge!(item[:external_urls])
        @failures.concat(item[:failures])
      end

      # TODO: lazy. if we're checking only external links,
      # we'll just trash all the failed tests. really, we should
      # just not run those other checks at all.
      if @options[:external_only]
        @failures = []
        validate_external_urls
      elsif !@options[:disable_external]
        validate_external_urls
        validate_internal_urls
      else
        validate_internal_urls
      end
    end

    # Walks over each implemented check and runs them on the files, in parallel.
    def process_files
      if @options[:parallel].empty?
        files.map { |path| check_path(path) }
      else
        Parallel.map(files, @options[:parallel]) { |path| check_path(path) }
      end
    end

    def check_parsed(html, path)
      result = { external_urls: {}, failures: [] }

      @src = [@src] if @type == :file

      @src.each do |src|
        checks.each do |klass|
          @logger.log :debug, "Checking #{klass.to_s.downcase} on #{path} ..."
          check = Object.const_get(klass).new(src, path, html, @logger, @cache, @options)
          check.run

          if klass == 'LinkCheck'
            @internal_link_checks = check
            check.internal_urls.each_pair do |url, internal_urls|
              if @internal_urls_to_paths[url]
                @internal_urls_to_paths[url].concat(internal_urls.map(&:path))
              else
                @internal_urls_to_paths[url] = internal_urls.map(&:path)
              end
            end
            @internal_urls.merge!(check.internal_urls)
          end

          external_urls = check.external_urls
          external_urls = check.external_urls.transform_keys { |url| swap(url, @options[:url_swap]) } if @options[:url_swap]
          result[:external_urls].merge!(external_urls)
          result[:failures].concat(check.issues)
        end
      end
      result
    end

    def check_path(path)
      check_parsed(create_nokogiri(path), path)
    end

    def validate_external_urls
      url_validator = HTMLProofer::UrlValidator.new(@logger, @cache, @external_urls, @options)
      url_validator.before_request = @before_request
      @failures.concat(url_validator.run)
      @external_urls = url_validator.external_urls
    end

    def validate_internal_urls
      if @cache.use_cache?
        urls_to_check = load_internal_cache

        urls_to_check.each_pair do |url, internal_urls|
          # pulled from cache
          internal_urls = @internal_urls[url] unless internal_urls.first.is_a?(LinkCheck::InternalLink)

          result = @internal_link_checks.check_internal_link(internal_urls.first.link, internal_urls.first.path, internal_urls.first.line, internal_urls.first.content)
          code = result ? 200 : 404
          @cache.add(url, @internal_urls_to_paths[url].sort, code, '') # TODO: blank msg for now
        end
        @cache.write
      else
        @internal_urls.values.flatten.each do |internal_url|
          result = @internal_link_checks.check_internal_link(internal_url.link, internal_url.path, internal_url.line, internal_url.content)
          next if result

          @failures.concat(@internal_link_checks.issues) unless @internal_link_checks.issues.length.zero?
        end
      end
    end

    def files
      @files ||= if @type == :directory
                   @src.map do |src|
                     pattern = File.join(src, '**', "*#{@options[:extension]}")
                     files = Dir.glob(pattern).select { |fn| File.file? fn }
                     files.reject { |f| ignore_file?(f) }
                   end.flatten
                 elsif @type == :file && File.extname(@src) == @options[:extension]
                   [@src].reject { |f| ignore_file?(f) }
                 else
                   []
                 end
    end

    def ignore_file?(file)
      @options[:file_ignore].each do |pattern|
        return true if pattern.is_a?(String) && pattern == file
        return true if pattern.is_a?(Regexp) && pattern =~ file
      end

      false
    end

    def checks
      return @checks if defined?(@checks) && !@checks.nil?

      return (@checks = ['LinkCheck']) if @type == :links

      @checks = HTMLProofer::Check.subchecks.map(&:name)
      @checks.delete('FaviconCheck') unless @options[:check_favicon]
      @checks.delete('HtmlCheck') unless @options[:check_html]
      @checks.delete('OpenGraphCheck') unless @options[:check_opengraph]
      @options[:checks_to_ignore].each { |ignored| @checks.delete(ignored) }
      @checks
    end

    def failed_tests
      result = []
      return result if @failures.empty?

      @failures.each { |f| result << f.to_s }
      result
    end

    def print_failed_tests
      sorted_failures = SortedIssues.new(@failures, @options[:error_sort], @logger)

      sorted_failures.sort_and_report
      count = @failures.length
      failure_text = pluralize(count, 'failure', 'failures')
      @logger.log :fatal, "\nHTML-Proofer found #{failure_text}!"
      exit 1
    end

    # Set before_request callback.
    #
    # @example Set before_request.
    #   request.before_request { |request| p "yay" }
    #
    # @param [ Block ] block The block to execute.
    #
    # @yield [ Typhoeus::Request ]
    #
    # @return [ Array<Block> ] All before_request blocks.
    def before_request(&block)
      @before_request ||= []
      @before_request << block if block
      @before_request
    end

    def load_internal_cache
      urls_to_check = @cache.retrieve_urls(@internal_urls, :internal)
      cache_text = pluralize(urls_to_check.count, 'internal link', 'internal links')
      @logger.log :info, "Found #{cache_text} in the cache..."

      urls_to_check
    end
  end
end
