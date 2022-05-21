# frozen_string_literal: true

class ScriptCheck < ::HTMLProofer::Check
  attr_reader :src

  def missing_src?
    !@script.src
  end

  def run
    @html.css('script').each do |node|
      @script = create_element(node)
      line = node.line
      content = node.content

      next if @script.ignore?
      next unless node.text.strip.empty?

      # does the script exist?
      if missing_src?
        add_issue('script is empty and has no src attribute', line: line, content: content)
      elsif @script.remote?
        add_to_external_urls(@script.src)
        check_sri(line, content) if @script.check_sri?
      elsif !@script.exists?
        add_issue("internal script #{@script.src} does not exist", line: line, content: content)
      end
    end

    external_urls
  end

  def check_sri(line, content)
    if !defined?(@script.integrity) && !defined?(@script.crossorigin)
      add_issue("SRI and CORS not provided in: #{@script.src}", line: line, content: content)
    elsif !defined?(@script.integrity)
      add_issue("Integrity is missing in: #{@script.src}", line: line, content: content)
    elsif !defined?(@script.crossorigin)
      add_issue("CORS not provided for external resource in: #{@script.src}", line: line, content: content)
    end
  end
end
