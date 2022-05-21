module Regexp::Expression
  # TODO: in v3.0.0, maybe put Shared back into Base, and inherit from Base and
  # call super in #initialize, but raise in #quantifier= and #quantify,
  # or introduce an Expression::Quantifiable intermediate class.
  # Or actually allow chaining as a more concise but tricky solution than PR#69.
  class Quantifier
    include Regexp::Expression::Shared

    MODES = %i[greedy possessive reluctant]

    attr_reader :min, :max, :mode

    def initialize(*args)
      deprecated_old_init(*args) and return if args.count == 4 || args.count == 5

      init_from_token_and_options(*args)
      @mode = (token[/greedy|reluctant|possessive/] || :greedy).to_sym
      @min, @max = minmax
      # TODO: remove in v3.0.0, stop removing parts of #token (?)
      self.token = token.to_s.sub(/_(greedy|possessive|reluctant)/, '').to_sym
    end

    def to_h
      {
        token: token,
        text:  text,
        mode:  mode,
        min:   min,
        max:   max,
      }
    end

    MODES.each do |mode|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{mode}?
          mode.equal?(:#{mode})
        end
      RUBY
    end
    alias :lazy? :reluctant?

    private

    def deprecated_old_init(token, text, min, max, mode = :greedy)
      warn "Calling `Expression::Base#quantify` or `#{self.class}.new` with 4+ arguments "\
           "is deprecated.\nIt will no longer be supported in regexp_parser v3.0.0.\n"\
           "Please pass a Regexp::Token instead, e.g. replace `type, text, min, max, mode` "\
           "with `::Regexp::Token.new(:quantifier, type, text)`. min, max, and mode "\
           "will be derived automatically. \nThis is consistent with how Expression::Base "\
           "instances are created."
      @token = token
      @text  = text
      @min   = min
      @max   = max
      @mode  = mode
    end

    def minmax
      case token
      when /zero_or_one/  then [0, 1]
      when /zero_or_more/ then [0, -1]
      when /one_or_more/  then [1, -1]
      when :interval
        int_min = text[/\{(\d*)/, 1]
        int_max = text[/,?(\d*)\}/, 1]
        [int_min.to_i, (int_max.empty? ? -1 : int_max.to_i)]
      end
    end
  end
end
