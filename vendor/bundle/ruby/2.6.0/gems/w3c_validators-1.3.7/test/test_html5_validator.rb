require File.expand_path('test_helper', File.dirname(__FILE__))

# Test cases for the HTML5Validator.
class HTML5ValidatorTests < Test::Unit::TestCase
  include W3CValidators
  def setup
    @v = NuValidator.new
    sleep 1
  end

  def test_getting_request_data
    VCR.use_cassette('html5_getting_request_data') do
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/valid_html5.html')
      assert_equal :html5, r.doctype
      assert_equal 'https://w3c-validators.github.io/w3c_validators/valid_html5.html', r.uri
      assert_no_errors r
      assert_no_warnings r
      assert r.is_valid?
    end
  end

  def test_validating_uri
    VCR.use_cassette('html5_validating_uri') do
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_html5.html')
      assert_errors r, 2
      assert_no_warnings r
      assert !r.is_valid?
    end
  end

  def test_validating_file
    VCR.use_cassette('html5_validating_file') do
      file = File.dirname(__FILE__) + '/fixtures/invalid_html5.html'
      r = @v.validate_file(file)
      assert_errors r, 2
      assert_no_warnings r
      assert !r.is_valid?
    end
  end

  def test_validating_text
    VCR.use_cassette('html5_validating_text') do
      valid_fragment = <<-EOV
      <!DOCTYPE html>
      <html lang="en-ca">
        <head>
          <title>HTML 5 Example</title>
        </head>
        <body>
          <!-- should have one error (missing </section>) -->
          <p>This is a sample HTML 5 document.</p>
          <section>
          <h1>Example of paragraphs</h1>
          This is the <em>first</em> paragraph in this example.
          <p>This is the second.</p>
          <p>Test<br>test</p>
        </body>
      </html>
      EOV
    
      r = @v.validate_text(valid_fragment)
      assert_errors r, 2
      assert_no_warnings r
      assert !r.is_valid?
    end
  end

  def test_validating_text_via_file
    VCR.use_cassette('html5_validating_text_via_file') do
      fh = File.new(File.dirname(__FILE__) + '/fixtures/invalid_html5.html', 'r+')    
      r = @v.validate_file(fh)
      fh.close
      assert_errors r, 2
      assert_no_warnings r
      assert !r.is_valid?
      # check content of first error
      assert_equal r.errors[0].line, 15
      assert_equal r.errors[0].col, 3
      assert r.errors[0].message =~ /unclosed elements/
      # check content of second error
      assert_equal r.errors[1].line, 10
      assert_equal r.errors[1].col, 5
      assert r.errors[1].message =~ /Unclosed element “section”/
    end
  end


end
