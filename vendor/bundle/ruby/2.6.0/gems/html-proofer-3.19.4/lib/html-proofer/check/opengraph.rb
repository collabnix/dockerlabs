# frozen_string_literal: true

class OpenGraphElement < ::HTMLProofer::Element
  attr_reader :src

  def initialize(obj, check, logger)
    super(obj, check, logger)
    # Fake up src from the content attribute
    instance_variable_set('@src', @content)

    @src.insert 0, 'http:' if %r{^//}.match?(@src)
  end
end

class OpenGraphCheck < ::HTMLProofer::Check
  def missing_src?
    !@opengraph.src
  end

  def empty_src?
    blank?(@opengraph.src)
  end

  def run
    @html.css('meta[property="og:url"], meta[property="og:image"]').each do |m|
      @opengraph = OpenGraphElement.new(m, self, @logger)

      next if @opengraph.ignore?

      # does the opengraph exist?
      if missing_src?
        add_issue('open graph has no content attribute', line: m.line, content: m.content)
      elsif empty_src?
        add_issue('open graph content attribute is empty', line: m.line, content: m.content)
      elsif !@opengraph.valid?
        add_issue("#{@opengraph.src} is an invalid URL", line: m.line)
      elsif @opengraph.remote?
        add_to_external_urls(@opengraph.url)
      else
        add_issue("internal open graph #{@opengraph.url} does not exist", line: m.line, content: m.content) unless @opengraph.exists?
      end
    end

    external_urls
  end
end
