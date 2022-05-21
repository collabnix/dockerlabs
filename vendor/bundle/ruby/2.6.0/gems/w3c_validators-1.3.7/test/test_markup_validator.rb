require File.expand_path('test_helper', File.dirname(__FILE__))

# Test cases for the MarkupValidator.
class MarkupValidatorTests < Test::Unit::TestCase
  include W3CValidators
  def setup
    @v = MarkupValidator.new
    sleep 1
  end

  def test_overriding_doctype
    VCR.use_cassette('markup_overriding_doctype') do
      @v.set_doctype!(:html32, false)
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup.html')
      assert_equal '-//W3C//DTD HTML 3.2 Final//EN', r.doctype
    end
  end

  def test_overriding_doctype_for_fallback_only
    VCR.use_cassette('markup_overriding_doctype_for_fallback_only') do
      @v.set_doctype!(:html32, true)
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup_1.html')
      assert_not_equal '-//W3C//DTD HTML 3.2 Final//EN', r.doctype
    end
  end

  def test_overriding_charset
    VCR.use_cassette('markup_overriding_charset') do
      @v.set_charset!(:utf_16, false)
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup_2.html')
      assert_equal 'utf-16', r.charset
    end
  end

  def test_overriding_charset_for_fallback_only
    VCR.use_cassette('markup_overriding_charset_for_fallback_only') do
      @v.set_doctype!(:utf_16, true)
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/markup_overriding_charset_for_fallback_only.html')
      assert_not_equal 'utf-16', r.charset
    end
  end

  def test_validating_uri_with_head_request
    VCR.use_cassette('markup_validating_uri_with_head_request') do
      r = @v.validate_uri_quickly('https://w3c-validators.github.io/w3c_validators/invalid_markup_4.html')
      assert_errors r, 1
    end
  end

  def test_validating_uri_with_soap
    VCR.use_cassette('markup_validating_uri_with_soap') do
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup_5.html')
      assert_errors r, 1
      assert_no_warnings r
    end
  end

  def test_debugging_uri
    VCR.use_cassette('markup_debugging_uri') do
      @v.set_debug!
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup_6.html')
      assert r.debug_messages.length > 0
    end
  end

  def test_validating_file
    VCR.use_cassette('markup_validating_file') do
      file = File.dirname(__FILE__) + '/fixtures/invalid_markup.html'
      r = @v.validate_file(file)
      assert_errors r, 1
    
      assert r.uri =~ /fixtures\/invalid_markup\.html$/
    end
  end

  def test_validating_text
    VCR.use_cassette('markup_validating_text') do
      valid_fragment = <<-EOV
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <title>Test</title>
        <body>
        <div class="example">This is a test</div>
        </body>
      EOV

      r = @v.validate_text(valid_fragment)
      assert_no_errors r
      assert_warnings r, 2
    end
  end

  def test_validating_text_via_file
    VCR.use_cassette('markup_validating_text_via_file') do
      fh = File.new(File.dirname(__FILE__) + '/fixtures/invalid_markup.html', 'r+')
      r = @v.validate_file(fh)
      fh.close
      assert_errors r, 1
    end
  end


  def test_validator_abort
    VCR.use_cassette('markup_validator_abort') do
      @v.set_debug!
      assert_nothing_raised do
        r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_encoding.html')
        assert !r.is_valid?
        assert_errors r, 1
        assert_no_warnings r
      end
    end
  end

  def test_validator_contains_details_of_error_conditions
    VCR.use_cassette('markup_validator_contains_details_of_error_conditions') do
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_markup_7.html')
      assert_not_nil r.errors[0].col
      assert_not_nil r.errors[0].line
      assert_not_nil r.errors[0].message
    end
  end
end

