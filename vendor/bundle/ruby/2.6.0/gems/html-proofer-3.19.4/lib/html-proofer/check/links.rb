# frozen_string_literal: true

class LinkCheck < ::HTMLProofer::Check
  include HTMLProofer::Utils

  def missing_href?
    return blank?(@link.src) if @node.name == 'source'

    blank?(@link.href) && blank?(@link.name) && blank?(@link.id)
  end

  def placeholder?
    (!blank?(@link.id) || !blank?(@link.name)) && @link.href.nil?
  end

  def run
    @html.css('a, link, source').each do |node|
      @link = create_element(node)
      line = node.line
      content = node.to_s

      next if @link.ignore?

      next if placeholder?
      next if @link.allow_hash_href? && @link.href == '#'

      # is it even a valid URL?
      unless @link.valid?
        add_issue("#{@link.href} is an invalid URL", line: line, content: content)
        next
      end

      check_schemes(@link, line, content)

      # is there even an href?
      if missing_href?
        next if @link.allow_missing_href?
        # HTML5 allows dropping the href: http://git.io/vBX0z
        next if @html.internal_subset.nil? || (@html.internal_subset.name == 'html' && @html.internal_subset.external_id.nil?)

        add_issue('anchor has no href attribute', line: line, content: content)
        next
      end

      # intentionally here because we still want valid? & missing_href? to execute
      next if @link.non_http_remote?

      if !@link.href&.start_with?('#') && !@link.internal? && @link.remote?
        check_sri(line, content) if @link.check_sri? && node.name == 'link'
        # we need to skip these for now; although the domain main be valid,
        # curl/Typheous inaccurately return 404s for some links. cc https://git.io/vyCFx
        next if @link.respond_to?(:rel) && @link.rel == 'dns-prefetch'

        unless @link.path?
          add_issue("#{@link.href} is an invalid URL", line: line, content: content)
          next
        end

        add_to_external_urls(@link.href || @link.src)
        next
      elsif @link.internal?
        add_to_internal_urls(@link.href, InternalLink.new(@link, @path, line, content))
        add_issue("internally linking to #{@link.href}, which does not exist", line: line, content: content) if !@link.exists? && !@link.hash
      end
    end

    external_urls
  end

  def check_internal_link(link, path, line, content)
    # does the local directory have a trailing slash?
    if link.unslashed_directory?(link.absolute_path)
      add_issue("internally linking to a directory #{link.absolute_path} without trailing slash", path: path, line: line, content: content)
      return false
    end

    return true unless link.hash

    # verify the target hash
    handle_hash(link, path, line, content)
  end

  def check_schemes(link, line, content)
    case link.scheme
    when 'mailto'
      handle_mailto(link, line, content)
    when 'tel'
      handle_tel(link, line, content)
    when 'http'
      return unless @options[:enforce_https]

      add_issue("#{link.href} is not an HTTPS link", line: line, content: content)
    end
  end

  def handle_mailto(link, line, content)
    if link.path.empty?
      add_issue("#{link.href} contains no email address", line: line, content: content) unless link.ignore_empty_mailto?
    elsif !link.path.include?('@')
      add_issue("#{link.href} contains an invalid email address", line: line, content: content)
    end
  end

  def handle_tel(link, line, content)
    add_issue("#{link.href} contains no phone number", line: line, content: content) if link.path.empty?
  end

  def handle_hash(link, path, line, content)
    if link.internal? && !hash_exists?(link.html, link.hash) # rubocop:disable Style/GuardClause
      return add_issue("linking to internal hash ##{link.hash} that does not exist", path: path, line: line, content: content)
    elsif link.external?
      return external_link_check(link, line, content)
    end

    true
  end

  def external_link_check(link, line, content)
    if link.exists? # rubocop:disable Style/GuardClause
      target_html = create_nokogiri(link.absolute_path)
      return add_issue("linking to #{link.href}, but #{link.hash} does not exist", line: line, content: content) unless hash_exists?(target_html, link.hash)
    else
      return add_issue("trying to find hash of #{link.href}, but #{link.absolute_path} does not exist", line: line, content: content)
    end

    true
  end

  def hash_exists?(html, href_hash)
    decoded_href_hash = Addressable::URI.unescape(href_hash)
    fragment_ids = [href_hash, decoded_href_hash]
    # https://www.w3.org/TR/html5/single-page.html#scroll-to-fragid
    fragment_ids.include?('top') || !find_fragments(html, fragment_ids).empty?
  end

  def find_fragments(html, fragment_ids)
    xpaths = fragment_ids.flat_map do |frag_id|
      escaped_frag_id = "'#{frag_id.split("'").join("', \"'\", '")}', ''"
      [
        "//*[case_sensitive_equals(@id, concat(#{escaped_frag_id}))]",
        "//*[case_sensitive_equals(@name, concat(#{escaped_frag_id}))]"
      ]
    end
    xpaths << XpathFunctions.new

    html.xpath(*xpaths)
  end

  # Whitelist for affected elements from Subresource Integrity specification
  # https://w3c.github.io/webappsec-subresource-integrity/#link-element-for-stylesheets
  SRI_REL_TYPES = %(stylesheet)

  def check_sri(line, content)
    return unless SRI_REL_TYPES.include?(@link.rel)

    if !defined?(@link.integrity) && !defined?(@link.crossorigin)
      add_issue("SRI and CORS not provided in: #{@link.src}", line: line, content: content)
    elsif !defined?(@link.integrity)
      add_issue("Integrity is missing in: #{@link.src}", line: line, content: content)
    elsif !defined?(@link.crossorigin)
      add_issue("CORS not provided for external resource in: #{@link.src}", line: line, content: content)
    end
  end

  class XpathFunctions
    def case_sensitive_equals(node_set, str_to_match)
      node_set.find_all { |node| node.to_s.== str_to_match.to_s }
    end
  end

  class InternalLink
    attr_reader :link, :href, :path, :line, :content

    def initialize(link, path, line, content)
      @link = link
      @href = @link.href
      @path = path
      @line = line
      @content = content
    end
  end
end
