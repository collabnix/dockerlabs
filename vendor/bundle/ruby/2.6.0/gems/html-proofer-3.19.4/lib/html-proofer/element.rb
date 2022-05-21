# frozen_string_literal: true

require 'addressable/uri'
require_relative './utils'

module HTMLProofer
  # Represents the element currently being processed
  class Element
    include HTMLProofer::Utils

    attr_reader :id, :name, :alt, :href, :link, :src, :line, :data_proofer_ignore

    def initialize(obj, check, logger)
      @logger = logger
      # Construct readable ivars for every element
      begin
        obj.attributes.each_pair do |attribute, value|
          name = attribute.tr('-:.;@', '_').to_s.to_sym
          (class << self; self; end).send(:attr_reader, name)
          instance_variable_set("@#{name}", value.value)
        end
      rescue NameError => e
        @logger.log :error, "Attribute set `#{obj}` contains an error!"
        raise e
      end

      @aria_hidden = defined?(@aria_hidden) && @aria_hidden == 'true'

      @data_proofer_ignore = defined?(@data_proofer_ignore)

      @text = obj.content
      @check = check
      @checked_paths = {}
      @type = check.class.name
      @line = obj.line

      @html = check.html

      parent_attributes = obj.ancestors.map { |a| a.respond_to?(:attributes) && a.attributes }
      parent_attributes.pop # remove document at the end
      @parent_ignorable = parent_attributes.any? { |a| !a['data-proofer-ignore'].nil? }

      # fix up missing protocols
      if defined?(@href)
        @href.insert(0, 'http:') if %r{^//}.match?(@href)
      else
        @href = nil
      end

      if defined?(@src)
        @src.insert(0, 'http:') if %r{^//}.match?(@src)
      else
        @src = nil
      end

      if defined?(@srcset)
        @srcset.insert(0, 'http:') if %r{^//}.match?(@srcset)
      else
        @srcset = nil
      end
    end

    def url
      return @url if defined?(@url)

      @url = (@src || @srcset || @href || '').delete("\u200b").strip
      @url = Addressable::URI.join(base.attr('href') || '', url).to_s if base
      return @url if @check.options[:url_swap].empty?

      @url = swap(@url, @check.options[:url_swap])
    end

    def valid?
      !parts.nil?
    end

    def path?
      !parts.host.nil? && !parts.path.nil?
    end

    def parts
      @parts ||= Addressable::URI.parse url
    rescue URI::Error, Addressable::URI::InvalidURIError
      @parts = nil
    end

    def path
      Addressable::URI.unencode parts.path unless parts.nil?
    end

    def hash
      parts&.fragment
    end

    def scheme
      parts&.scheme
    end

    # path is to an external server
    def remote?
      %w[http https].include? scheme
    end

    def non_http_remote?
      !scheme.nil? && !remote?
    end

    def ignore?
      return true if @data_proofer_ignore
      return true if @parent_ignorable

      return true if /^javascript:/.match?(url)

      # ignore base64 encoded images
      return true if %w[ImageCheck FaviconCheck].include?(@type) && /^data:image/.match?(url)

      # ignore user defined URLs
      return true if ignores_pattern_check(@check.options[:url_ignore])
    end

    def ignore_alt?
      return true if ignores_pattern_check(@check.options[:alt_ignore]) || @aria_hidden
    end

    def ignore_empty_alt?
      @check.options[:empty_alt_ignore]
    end

    def allow_missing_href?
      @check.options[:allow_missing_href]
    end

    def allow_hash_href?
      @check.options[:allow_hash_href]
    end

    def check_img_http?
      @check.options[:check_img_http]
    end

    def check_sri?
      @check.options[:check_sri]
    end

    def ignore_empty_mailto?
      @check.options[:ignore_empty_mailto]
    end

    # path is external to the file
    def external?
      !internal?
    end

    def internal?
      relative_link? || internal_absolute_link?
    end

    def internal_absolute_link?
      url.start_with?('/')
    end

    def relative_link?
      return false if remote?

      hash_link || param_link || url.start_with?('.') || url =~ /^\S/
    end

    def link_points_to_same_page?
      hash_link || param_link
    end

    def hash_link
      url.start_with?('#')
    end

    def param_link
      url.start_with?('?')
    end

    def absolute_path?(path)
      path.start_with?('/')
    end

    def file_path
      return if path.nil? || path.empty?

      path_dot_ext = ''

      path_dot_ext = path + @check.options[:extension] if @check.options[:assume_extension]

      base = if absolute_path?(path) # path relative to root
               # either overwrite with root_dir; or, if source is directory, use that; or, just get the current file's dirname
               @check.options[:root_dir] || (File.directory?(@check.src) ? @check.src : File.dirname(@check.src))
             elsif File.exist?(File.expand_path(path, @check.src)) || File.exist?(File.expand_path(path_dot_ext, @check.src)) # relative links, path is a file
               File.dirname(@check.path)
             elsif File.exist?(File.join(File.dirname(@check.path), path)) || File.exist?(File.join(File.dirname(@check.path), path_dot_ext)) # rubocop:disable Lint/DuplicateBranch; relative links in nested dir, path is a file
               File.dirname(@check.path)
             else # relative link, path is a directory
               @check.path
             end

      file = File.join(base, path)

      if @check.options[:assume_extension] && File.file?("#{file}#{@check.options[:extension]}")
        file = "#{file}#{@check.options[:extension]}"
      elsif File.directory?(file) && !unslashed_directory?(file) # implicit index support
        file = File.join file, @check.options[:directory_index_file]
      end

      file
    end

    # checks if a file exists relative to the current pwd
    def exists?
      return @checked_paths[absolute_path] if @checked_paths.key?(absolute_path)

      @checked_paths[absolute_path] = File.exist?(absolute_path)
    end

    def absolute_path
      path = file_path || @check.path

      File.expand_path(path, Dir.pwd)
    end

    def ignores_pattern_check(links)
      return false unless links.is_a?(Array)

      links.each do |ignore|
        case ignore
        when String
          return true if ignore == url
        when Regexp
          return true if ignore&.match?(url)
        end
      end

      false
    end

    def unslashed_directory?(file)
      File.directory?(file) && !file.end_with?(File::SEPARATOR) && !follow_location?
    end

    def follow_location?
      @check.options[:typhoeus] && @check.options[:typhoeus][:followlocation]
    end

    def base
      @base ||= @html.at_css('base')
    end

    def html
      # If link is on the same page, then URL is on the current page. use the same HTML as for current page
      if link_points_to_same_page?
        @html
      elsif internal?
        # link on another page, e.g. /about#Team - need to get HTML from the other page
        create_nokogiri(absolute_path)
      else
        raise NotImplementedError, 'HTMLProofer should not have gotten here. Please report this as a bug.'
      end
    end
  end
end
