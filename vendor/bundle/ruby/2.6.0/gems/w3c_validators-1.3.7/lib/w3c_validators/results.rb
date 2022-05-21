module W3CValidators
  class Results
    attr_reader :uri, :checked_by, :doctype, :css_level, :charset, :validity, :debug_messages

    def initialize(options = {})
      @messages       = []
      @uri            = options[:uri]
      @checked_by     = options[:checked_by]
      @doctype        = options[:doctype]
      @css_level      = options[:css_level]
      @charset        = options[:charset]
      if options[:validity].kind_of?(String)
        @validity     = options[:validity].downcase.strip == 'true'
      else
        @validity     = options[:validity]
      end
      @debug_messages = {}
    end

    def add_message(type, params = {})
      uri = params[:uri] ||= @uri
      @messages << Message.new(uri, type, params)
    end    

    def add_error(params = {})
      add_message(:error, params)
    end

    def add_warning(params = {})
      add_message(:warning, params)
    end

    def add_debug_message(key, val)
      @debug_messages[key] = val
    end

    # Returns either the +DOCTYPE+ or CSS level, whichever is present.
    def checked_against
      return @doctype if @doctype
      return @css_level if @css_level
      nil
    end

    def is_valid?
      @validity
    end

    # Returns an array of Message objects.
    def errors
      errors = []
      @messages.each { |msg| errors << msg if msg.is_error? }
      errors
    end

    # Returns an array of Message objects.
    def warnings
      errors = []
      @messages.each { |msg| errors << msg if msg.is_warning? }
      errors
    end
  end
end