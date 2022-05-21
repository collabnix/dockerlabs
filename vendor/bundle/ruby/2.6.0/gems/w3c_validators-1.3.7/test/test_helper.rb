$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'test/unit'
require 'w3c_validators'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/http_recording"
  config.hook_into :webmock # or :fakeweb
end

class Test::Unit::TestCase

  def assert_no_errors(response)
    assert response.errors.empty?, response.errors.map { |e| e.to_s }.join('. ')
  end
  
  def assert_no_warnings(response)
    assert response.warnings.empty?, response.warnings.map { |w| w.to_s }.join('. ')
  end
  
  def assert_errors(response, quantity = nil)
    case quantity
      when 0
        assert_no_errors response
      when nil
        assert response.errors.any?
      else
        assert_equal quantity, response.errors.length
    end
  end
  
  def assert_warnings(response, quantity = nil)
    case quantity
      when 0
        assert_no_warnings response
      when nil
        assert response.warnings.any?
      else
        assert_equal quantity, response.warnings.length
    end
  end

end
