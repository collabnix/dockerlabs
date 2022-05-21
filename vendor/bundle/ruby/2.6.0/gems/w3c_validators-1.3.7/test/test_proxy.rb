require File.expand_path('test_helper', File.dirname(__FILE__))

require 'webrick'
require 'webrick/httpproxy'

# Test cases for the ProxyTests.
class ProxyTests < Test::Unit::TestCase
  include W3CValidators

  def setup
    @ps = WEBrick::HTTPProxyServer.new(:Port => 9999, :ServerType => Thread, :RequestCallback => Proc.new{|req,res| puts req.request_line, req.raw_header})
  
    ['TERM', 'INT'].each do |signal|
      trap(signal){ @ps.shutdown }
    end

    @ps.start

    @v = MarkupValidator.new({:proxy_server => 'localhost', :proxy_port => 9999})
    sleep 1
  end


  def test_validating_uri_with_head_request
    omit("Pending, to prevent w3.org abuse")
    VCR.use_cassette('markup_overriding_doctype') do
      r = @v.validate_uri_quickly('https://w3c-validators.github.io/w3c_validators/invalid_markup_8.html')
      assert_errors r, 1
    end
  end
end
