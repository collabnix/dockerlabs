# frozen_string_literal: true

module HTMLProofer
  class Middleware
    include HTMLProofer::Utils

    class InvalidHtmlError < StandardError
      def initialize(failures)
        super
        @failures = failures
      end

      def message
        "HTML Validation errors (skip by adding `?proofer-ignore` to URL): \n#{@failures.join("\n")}"
      end
    end

    def self.options
      @options ||= {
        type: :file,
        allow_missing_href: true, # Permitted in html5
        allow_hash_href: true,
        check_external_hash: true,
        check_html: true,
        url_ignore: [%r{^/}], # Don't try to check if local files exist
        validation: { report_eof_tags: true }
      }
    end

    def initialize(app)
      @app = app
    end

    HTML_SIGNATURE = [
      '<!DOCTYPE HTML',
      '<HTML',
      '<HEAD',
      '<SCRIPT',
      '<IFRAME',
      '<H1',
      '<DIV',
      '<FONT',
      '<TABLE',
      '<A',
      '<STYLE',
      '<TITLE',
      '<B',
      '<BODY',
      '<BR',
      '<P',
      '<!--'
    ].freeze

    def call(env)
      result = @app.call(env)
      return result if env['REQUEST_METHOD'] != 'GET'
      return result if /proofer-ignore/.match?(env['QUERY_STRING'])
      return result if result.first != 200

      body = []
      result.last.each { |e| body << e }

      body = body.join
      begin
        html = body.lstrip
      rescue StandardError
        return result # Invalid encoding; it's not gonna be html.
      end
      if HTML_SIGNATURE.any? { |sig| html.upcase.start_with? sig }
        parsed = HTMLProofer::Runner.new(
          'response',
          Middleware.options
        ).check_parsed(
          Nokogiri::HTML5(html, max_errors: -1), 'response'
        )

        raise InvalidHtmlError, parsed[:failures] unless parsed[:failures].empty?
      end
      result
    end
  end
end
