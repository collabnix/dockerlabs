# frozen_string_literal: true

class FaviconCheck < ::HTMLProofer::Check
  def run
    found = false
    @html.xpath('//link[not(ancestor::pre or ancestor::code)]').each do |node|
      favicon = create_element(node)
      next if favicon.ignore?

      found = true if favicon.rel.split.last.eql? 'icon'
      break if found
    end

    return if found

    return if immediate_redirect?

    add_issue('no favicon specified')
  end

  private

  # allow any instant-redirect meta tag
  def immediate_redirect?
    @html.xpath("//meta[@http-equiv='refresh']").attribute('content').value.start_with? '0;'
  rescue StandardError
    false
  end
end
