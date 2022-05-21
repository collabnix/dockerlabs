require File.expand_path('test_helper', File.dirname(__FILE__))

# Test cases for the CSSValidator.
class CSSValidatorTests < Test::Unit::TestCase
  include W3CValidators
  def setup
    @v = CSSValidator.new

    @invalid_fragment = <<-EOT
    a { color: white; }
    body { margin: blue; }
    
    EOT

    sleep 1
  end

  def test_overriding_css_profile
    VCR.use_cassette('css_overriding_css_profile') do
      @v.set_profile!(:css21)
      r = @v.validate_text(@invalid_fragment)
      assert_equal 'css21', r.css_level
    end
  end

  def test_validating_file
    VCR.use_cassette('css_validating_file') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_css.css')
      r = @v.validate_file(file_path)
      assert_errors r, 1
    end
  end

  def test_validating_uri
    VCR.use_cassette('css_validating_uri') do
      @v.set_profile!(:svgbasic)
      r = @v.validate_text(@invalid_fragment)
      assert_errors r, 1
    end
  end

  def test_validating_text
    VCR.use_cassette('css_validating_text') do
      r = @v.validate_text(@invalid_fragment)
      assert_errors r, 1
    end
  end

  def test_validating_text_via_file
    VCR.use_cassette('css_validating_text_via_file') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_css.css')
      fh = File.new(file_path, 'r+')
      r = @v.validate_file(fh)
      fh.close
      assert_errors r, 1
    end
  end

  def test_validating_big_file
    VCR.use_cassette('css_validating_big_file') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/bootstrap.min.css')
      fh = File.new(file_path, 'r+')
      r = @v.validate_file(fh)
      fh.close
      assert_errors r
    end
  end

  def test_context
    VCR.use_cassette('css_context') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_css.css')
      results = @v.validate_file(file_path)
      assert results.errors.first.context == "body"
    end
  end

  def test_skippedstring
    VCR.use_cassette('css_skippedstring') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_css.css')
      results = @v.validate_file(file_path)
      assert results.errors.first.skippedstring == "blue"
    end
  end
 
  def test_vendor_extensions_default
    VCR.use_cassette('css_vendor_extensions_default') do
      @v.set_vendor_extension_warning!
      r = @v.validate_text("p { -moz-border-radius: 5px; }")
      assert_errors r, 0
      assert_warnings r, 1
    end
  end

  def test_vendor_extensions_as_errors
    VCR.use_cassette('css_vendor_extensions_as_errors') do
      @v.set_vendor_extension_warning!('Errors')
      r = @v.validate_text('some-class { -moz-border-radius: 3px; }')
      assert_errors r, 1
      assert_no_warnings r
    end
  end

  def test_vendor_extensions_as_warnings
    VCR.use_cassette('css_vendor_extensions_as_warnings') do
      @v.set_vendor_extension_warning!('Warnings')
      r = @v.validate_text('some-class { -moz-border-radius: 3px; }')
      assert_no_errors r
      assert_warnings r, 1
    end
  end

end
