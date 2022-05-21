module W3CValidators
  class Message
    attr_accessor :type, :line, :col, :source, :explanation, :message, :message_id
    attr_accessor :message_count, :element, :parent, :value, :context, :skippedstring
    
    MESSAGE_TYPES = [:warning, :error]

    # Due to the responses received from the W3C's validators, different data 
    # are available for different validation types.
    #
    # ==== Feed validation
    # * +line+
    # * +col+
    # * +message+ (originally +text+)
    # * +message_count+
    # * +element+
    # * +parent+
    # * +value+
    # See http://validator.w3.org/feed/docs/soap.html#soap12message for full explanations.
    #
    # ==== Markup validation
    # * +line+
    # * +col+
    # * +message+
    # * +message_id+
    # * +explanation+
    # * +source+
    # See http://validator.w3.org/docs/api.html#soap12message for full explanations.
    #
    # ==== CSS validation (http://jigsaw.w3.org/css-validator/api.html#soap12message)
    # * +level+
    # * +line+
    # * +message+
    # * +context+
    # * +skippedstring+
    # See http://jigsaw.w3.org/css-validator/api.html#soap12message for full explanations.
    def initialize(uri, message_type, options = {})
      @type = message_type
      @uri = uri

      # All validators
      @line = options[:line]
      @col = options[:col]
      
      # MarkupValidator
      @source = options[:source]
      @explanation = options[:explanation]
      @message = options[:message]
      @message_id = options[:messageid]

      # FeedValidator
      @message = options[:text] unless @message
      @message_count = options[:message_count]
      @element = options[:element]
      @parent = options[:parent]
      @value = options[:value]

      # CSSValidator
      @level          = options[:level]
      @context        = options[:context].strip       if options[:context]
      @skippedstring  = options[:skippedstring].strip if options[:skippedstring]
    end

    def is_warning?
      @type == :warning
    end

    def is_error?
      @type == :error
    end

    # Return the message as a string.
    def to_s
      str = @type.to_s.upcase
      if @uri and not @uri.empty?
        str << "; URI: #{@uri}"
      end
      str << "; line #{@line}"
      if @message and not @message.empty?
        str << ": #{@message}"
      end
      return str
    end

  end
end