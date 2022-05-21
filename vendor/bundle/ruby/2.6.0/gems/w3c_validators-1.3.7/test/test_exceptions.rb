require File.expand_path('test_helper', File.dirname(__FILE__))

class ExceptionTests < Test::Unit::TestCase
  include W3CValidators

  def setup
    @valid_fragment = <<-EOV
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
      <title>Test</title>
      <body>
      <div class="example">This is a test</div>
      </body>
    EOV
  end

  def test_bad_validator_uri
    VCR.turned_off do
      WebMock.allow_net_connect!
      ['http://noexist/', 'http://noexist.badtld/',
       'http://example.com/noexist', 'http://localhost:9999/'].each do |uri|
        v = MarkupValidator.new(:validator_uri => uri)
        assert_raise ValidatorUnavailable do
          v.validate_text(@valid_fragment)
        end
      end
      WebMock.disable_net_connect!
    end
  end

  def test_bad_soap_response
    omit("Pending, broken")
    [].each do |uri|
      v = MarkupValidator.new(:validator_uri => uri)
      assert_raise ParsingError do
        v.validate_text(@valid_fragment)
      end
    end
  end
end
