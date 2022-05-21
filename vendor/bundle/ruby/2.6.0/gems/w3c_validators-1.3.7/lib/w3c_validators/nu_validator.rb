require 'json'

module W3CValidators
  class NuValidator < Validator
    MARKUP_VALIDATOR_URI      = 'https://validator.w3.org/nu/'

    # Create a new instance of the NuValidator.
    #
    # ==== Options
    # The +options+ hash allows you to set request parameters (see 
    # http://wiki.whatwg.org/wiki/Validator.nu_Common_Input_Parameters) quickly. Request 
    # parameters can also be set using set_charset! and set_doctype!.
    #
    # You can pass in your own validator's URI (i.e. 
    # <tt>NuValidator.new(:validator_uri => 'http://localhost/check')</tt>).
    #
    # See Validator#new for proxy server options.
    def initialize(options = {})
      options[:parser] = 'html'
      if options[:validator_uri]
        @validator_uri = URI.parse(options[:validator_uri])
        options.delete(options[:validator_uri])
      else
        @validator_uri = URI.parse(MARKUP_VALIDATOR_URI)
      end
      super(options)
    end


    # Validate the markup of an URI.
    #
    # Returns W3CValidators::Results.
    def validate_uri(uri)
      return validate({:doc => uri})
    end


    # Validate the markup of a string.
    #
    # Returns W3CValidators::Results.
    def validate_text(text)
      return validate({:content => text})
    end
    
    # Validate the markup of a local file.
    #
    # +file+ may be either the fully-expanded path to the file or
    # an IO object (like File).
    #
    # Returns W3CValidators::Results.
    def validate_file(file)
      if file.respond_to? :read
        src = file.read
      else
        src = read_local_file(file)
      end 

      return validate_text(src)
    end

protected
    def validate(options) # :nodoc:
      options = get_request_options(options)
      
      if options.has_key?(:doc)
        response = send_request(options, :get)
      else
        # we force the file to be sent in the request body
        options.merge!({:post => :body})
        response = send_request(options, :post, false, :content)
      end

      @results = parse_json_response(response.body)
      @results
    end

    # Perform sanity checks on request params
    def get_request_options(options) # :nodoc:
      options = @options.merge(options)
     
      options[:out] = 'json'

      # only option that is currently supported
      options[:showsource] = 'yes'

      unless options[:doc] or options[:file] or options[:content]
        raise ArgumentError, "an uri, file or block of text is required."
      end

      # URI should be a string.  If it is a URI object, .to_s will
      # be seamless; if it is not an exception will be raised.
      if options[:doc] and not options[:doc].kind_of?(String)
        options[:doc] = options[:doc].to_s
      end
      options
    end


    # Parse the JSON response.
    #
    # +response+ must be a Net::HTTPResponse.
    #
    # Returns W3CValidators::Results.
    def parse_json_response(response) # :nodoc:
      doc = JSON.parse(response)

      result_params = {
        :doctype => :html5,
        :checked_by => MARKUP_VALIDATOR_URI
        }

      result_params[:uri] = doc['url'] ||= nil
      if doc['source']
        result_params[:charset] = doc['source']['encoding'] ||= nil
      end

      result_params[:validity] = !doc['messages'].any? { |msg| msg['type'] =~ /^error$/i }

      results = Results.new(result_params)

      doc['messages'].each do |msg|
        if msg['type'] =~ /^error$/i
          msg_type = :error
        elsif msg['subType'] =~ /^warning$/
          msg_type = :warning
        else
          next
          # TODO: should throw exceptions here
        end

        message_params = {
          :line => msg['lastLine'],
          :col => msg['firstColumn'],
          :message => msg['message'],
          :source => msg['extract']
        }

        results.add_message(msg_type, message_params)
      end

      return results

    rescue Exception => e
      handle_exception e
    end
  end
end
