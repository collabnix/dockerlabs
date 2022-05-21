require File.expand_path('test_helper', File.dirname(__FILE__))

# Test cases for the FeedValidator.
class FeedValidatorTests < Test::Unit::TestCase
  include W3CValidators
  def setup
    @v = FeedValidator.new
    sleep 1
  end

  def test_validating_uri_with_soap
    VCR.use_cassette('feed_validating_uri_with_soap') do
      r = @v.validate_uri('https://w3c-validators.github.io/w3c_validators/invalid_feed.xml')
      assert_errors r, 1
      assert_warnings r, 1
    end
  end
 
  def test_validating_file
    VCR.use_cassette('feed_validating_file') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_feed.xml')
      r = @v.validate_file(file_path)
      assert_errors r, 1
    end
  end
 
  def test_validating_text
    VCR.use_cassette('feed_validating_text') do
      fragment = <<-EOT
      <?xml version="1.0" encoding="utf-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom">
       <title>Example Feed</title>
       <subtitle>A subtitle.</subtitle>
       <link href="http://example.org/feed/" rel="self"/>
       <link href="http://example.org/"/>
       <updated>2003-12-13T18:30:02Z</updated>
       <author>
         <email>johndoe@example.com</email>
       </author>
       <id>urn:uuid:60a76c80-d399-11d9-b91C-0003939e0af6</id>
       <entry>
         <title>Atom-Powered Robots Run Amok</title>
         <link href="http://example.org/2003/12/13/atom03"/>
         <id>urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</id>
         <updated>2003-12-13T18:30:02Z</updated>
         <summary>Some text.</summary>
       </entry>
      </feed>
      EOT

      r = @v.validate_text(fragment)
      assert_equal 1, r.errors.length
    end
  end


  def test_validating_text_via_file
    VCR.use_cassette('feed_validating_text_via_file') do
      file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/invalid_feed.xml')
      fh = File.new(file_path, 'r+')
      r = @v.validate_file(fh)
      fh.close
      assert_errors r, 1
    end
  end

end

