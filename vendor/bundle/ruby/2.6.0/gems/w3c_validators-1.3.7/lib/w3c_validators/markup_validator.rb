module W3CValidators
  class MarkupValidator < Validator
    MARKUP_VALIDATOR_URI      = 'https://validator.w3.org/check'

    # Create a new instance of the MarkupValidator.
    #
    # ==== Options
    # The +options+ hash allows you to set request parameters (see
    # http://validator.w3.org/docs/api.html#requestformat) quickly. Request
    # parameters can also be set using set_charset!, set_debug! and set_doctype!.
    #
    # You can pass in your own validator's URI (i.e.
    # <tt>MarkupValidator.new(:validator_uri => 'http://localhost/check')</tt>).
    #
    # See Validator#new for proxy server options.
    def initialize(options = {})
      puts "The MarkupValidator class is deprecated (cf. https://validator.w3.org/docs/obsolete-api.html) as it cannot process HTML5 documents.\nPlease prefer the NuValidator class instead."
      if options[:validator_uri]
        @validator_uri = URI.parse(options[:validator_uri])
        options.delete(options[:validator_uri])
      else
        @validator_uri = URI.parse(MARKUP_VALIDATOR_URI)
      end
      super(options)
    end

    # Specify the character encoding to use when parsing the document.
    #
    # When +only_as_fallback+ is +true+, the given encoding will only be
    # used as a fallback value, in case the +charset+ is absent or unrecognized.
    #
    # +charset+ can be a string (e.g. <tt>set_charset!('utf-8')</tt>) or
    # a symbol (e.g. <tt>set_charset!(:utf_8)</tt>) from the
    # W3CValidators::CHARSETS hash.
    #
    # Has no effect when using validate_uri_quickly.
    def set_charset!(charset, only_as_fallback = false)
      if charset.kind_of?(Symbol)
        if CHARSETS.has_key?(charset)
          charset = CHARSETS[charset]
        else
          return
        end
      end
      @options[:charset] = charset
      @options[:fbc] = only_as_fallback
    end

    # Specify the Document Type (+DOCTYPE+) to use when parsing the document.
    #
    # When +only_as_fallback+ is +true+, the given document type will only be
    # used as a fallback value, in case the document's +DOCTYPE+ declaration
    # is missing or unrecognized.
    #
    # +doctype+ can be a string (e.g. <tt>set_doctype!('HTML 3.2')</tt>) or
    # a symbol (e.g. <tt>set_doctype!(:html32)</tt>) from the
    # W3CValidators::DOCTYPES hash.
    #
    # Has no effect when using validate_uri_quickly.
    def set_doctype!(doctype, only_as_fallback = false)
      if doctype.kind_of?(Symbol)
        if DOCTYPES.has_key?(doctype)
          doctype = DOCTYPES[doctype]
        else
          return
        end
      end
      @options[:doctype] = doctype
      @options[:fbd] = only_as_fallback
    end

    # When set the validator will output some extra debugging information on
    # the validated resource (such as HTTP headers) and validation process
    # (such as parser used, parse mode, etc.).
    #
    # Debugging information is stored in the Results +debug_messages+ hash.
    # Custom debugging messages can be set with Results#add_debug_message.
    #
    # Has no effect when using validate_uri_quickly.
    def set_debug!(debug = true)
      @options[:debug] = debug
    end

    # Validate the markup of an URI using a +SOAP+ request.
    #
    # Returns W3CValidators::Results.
    def validate_uri(uri)
      return validate({:uri => uri}, false)
    end

    # Validate the markup of an URI using a +HEAD+ request.
    #
    # Returns W3CValidators::Results with an error count, not full error messages.
    def validate_uri_quickly(uri)
      return validate({:uri => uri}, true)
    end

    # Validate the markup of a string.
    #
    # Returns W3CValidators::Results.
    def validate_text(text)
      return validate({:fragment => text}, false)
    end

    # Validate the markup of a local file.
    #
    # +file_path+ may be either the fully-expanded path to the file or
    # an IO object (like File).
    #
    # Returns W3CValidators::Results.
    def validate_file(file_path)
      if file_path.respond_to? :read
        src = file_path.read
      else
        src = read_local_file(file_path)
      end

      return validate({:uploaded_file => src, :file_path => file_path}, false)
    end

protected
    def validate(options, quick = false) # :nodoc:
      options = get_request_options(options)

      if quick
        response = send_request(options, :head)
        @results = parse_head_response(response, options[:uri])
      else
        if options.has_key?(:uri)
          response = send_request(options, :get)
        else
          response = send_request(options, :post)
        end
        @results = parse_soap_response(response.body)
      end
      @results
    end

    # Perform sanity checks on request params
    def get_request_options(options) # :nodoc:
      options = @options.merge(options)

      options[:output] = SOAP_OUTPUT_PARAM

      unless options[:uri] or options[:uploaded_file] or options[:fragment]
        raise ArgumentError, "an uri, uploaded file or fragment is required."
      end

      # URI should be a string.  If it is a URI object, .to_s will
      # be seamless; if it is not an exception will be raised.
      if options[:uri] and not options[:uri].kind_of?(String)
        options[:uri] = options[:uri].to_s
      end

      # Convert booleans to integers
      [:fbc, :fbd, :verbose, :debug, :ss, :outline].each do |k|
        if options.has_key?(k) and not options[k].kind_of?(Integer)
          options[k] = options[k] ? 1 : 0
        end
      end

      options
    end


    # Parse the SOAP XML response.
    #
    # +response+ must be a Net::HTTPResponse.
    #
    # Returns W3CValidators::Results.
    def parse_soap_response(response) # :nodoc:
      doc = Nokogiri::XML(response)
      doc.remove_namespaces!

      result_params = {}

      {:doctype => 'doctype', :uri => 'uri', :charset => 'charset',
       :checked_by => 'checkedby', :validity => 'validity'}.each do |local_key, remote_key|
        if val = doc.css(remote_key)
          result_params[local_key] = val.text
        end
      end

      results = Results.new(result_params)

      {:warning => 'warnings warning', :error => 'errorlist error'}.each do |local_type, remote_type|
        doc.css(remote_type).each do |message|
          message_params = {}
          message.children.each do |el|
            message_params[el.name.to_sym] = el.text unless el.blank?
          end
          results.add_message(local_type, message_params)
        end
      end

      doc.css("Fault Reason Text").each do |message|
        results.add_message(:error, {:mesage => message.text})
      end

      doc.css("markupvalidationresponse debug").each do |debug|
        results.add_debug_message(debug.attribute('name').value, debug.text)
      end
      return results

    rescue Exception => e
      handle_exception e
    end

    # Parse the HEAD response into HTMLValidator::Results.
    #
    # +response+ must be a Net::HTTPResponse.
    #
    # Returns Results.
    def parse_head_response(response, validated_uri = nil) # :nodoc:
      validity = (response[HEAD_STATUS_HEADER].downcase == 'valid')

      results = Results.new(:uri => validated_uri, :validity => validity)

      # Fill the results with empty error messages so we can count them
      errors = response[HEAD_ERROR_COUNT_HEADER].to_i
      errors.times { results.add_error }

      results
    end


  end
end
