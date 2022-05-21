# frozen_string_literal: true

module HTMLProofer
  module Configuration
    require_relative 'version'

    PROOFER_DEFAULTS = {
      allow_missing_href: false,
      allow_hash_href: false,
      alt_ignore: [],
      assume_extension: false,
      check_external_hash: false,
      check_favicon: false,
      check_html: false,
      check_img_http: false,
      check_opengraph: false,
      checks_to_ignore: [],
      check_sri: false,
      directory_index_file: 'index.html',
      disable_external: false,
      empty_alt_ignore: false,
      enforce_https: false,
      error_sort: :path,
      extension: '.html',
      external_only: false,
      file_ignore: [],
      http_status_ignore: [],
      internal_domains: [],
      log_level: :info,
      ignore_empty_mailto: false,
      only_4xx: false,
      url_ignore: [],
      url_swap: {}
    }.freeze

    TYPHOEUS_DEFAULTS = {
      followlocation: true,
      headers: {
        'User-Agent' => "Mozilla/5.0 (compatible; HTML Proofer/#{HTMLProofer::VERSION}; +https://github.com/gjtorikian/html-proofer)",
        'Accept' => 'application/xml,application/xhtml+xml,text/html;q=0.9, text/plain;q=0.8,image/png,*/*;q=0.5'
      },
      connecttimeout: 10,
      timeout: 30
    }.freeze

    HYDRA_DEFAULTS = {
      max_concurrency: 50
    }.freeze

    PARALLEL_DEFAULTS = {}.freeze

    VALIDATION_DEFAULTS = {
      report_script_embeds: false,
      report_missing_names: false,
      report_invalid_tags: false,
      report_missing_doctype: false,
      report_eof_tags: false,
      report_mismatched_tags: false
    }.freeze

    CACHE_DEFAULTS = {}.freeze

    def self.to_regex?(item)
      if item.start_with?('/') && item.end_with?('/')
        Regexp.new item[1...-1]
      else
        item
      end
    end

    def self.parse_json_option(option_name, config, symbolize_names: true)
      raise ArgumentError, 'Must provide an option name in string format.' unless option_name.is_a?(String)
      raise ArgumentError, 'Must provide an option name in string format.' if option_name.strip.empty?

      return {} if config.nil?

      raise ArgumentError, 'Must provide a JSON configuration in string format.' unless config.is_a?(String)

      return {} if config.strip.empty?

      begin
        JSON.parse(config, { symbolize_names: symbolize_names })
      rescue StandardError
        raise ArgumentError, "Option '#{option_name} did not contain valid JSON."
      end
    end
  end
end
