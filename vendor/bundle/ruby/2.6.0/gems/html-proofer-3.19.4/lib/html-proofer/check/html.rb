# frozen_string_literal: true

class HtmlCheck < ::HTMLProofer::Check
  # tags embedded in scripts are used in templating languages: http://git.io/vOovv
  SCRIPT_EMBEDS_MSG = /Element script embeds close tag/.freeze
  INVALID_TAG_MSG = /Tag ([\w\-:]+) invalid/.freeze
  INVALID_PREFIX = /Namespace prefix/.freeze
  PARSE_ENTITY_REF = /htmlParseEntityRef: no name/.freeze
  DOCTYPE_MSG = /Expected a doctype token/.freeze
  EOF_IN_TAG = /End of input in tag/.freeze
  MISMATCHED_TAGS = /That tag isn't allowed here/.freeze

  def run
    @html.errors.each do |error|
      add_issue(error.message, line: error.line) if report?(error.message)
    end
  end

  def report?(message)
    case message
    when SCRIPT_EMBEDS_MSG
      options[:validation][:report_script_embeds]
    when INVALID_TAG_MSG, INVALID_PREFIX
      options[:validation][:report_invalid_tags]
    when PARSE_ENTITY_REF
      options[:validation][:report_missing_names]
    when DOCTYPE_MSG
      options[:validation][:report_missing_doctype]
    when EOF_IN_TAG
      options[:validation][:report_eof_tags]
    when MISMATCHED_TAGS
      options[:validation][:report_mismatched_tags]
    else
      true
    end
  end
end
