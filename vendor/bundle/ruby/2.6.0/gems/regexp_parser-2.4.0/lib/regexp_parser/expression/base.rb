module Regexp::Expression
  class Base
    include Regexp::Expression::Shared

    def initialize(token, options = {})
      init_from_token_and_options(token, options)
    end

    def initialize_copy(orig)
      self.text       = orig.text.dup         if orig.text
      self.options    = orig.options.dup      if orig.options
      self.quantifier = orig.quantifier.clone if orig.quantifier
      super
    end

    def to_re(format = :full)
      ::Regexp.new(to_s(format))
    end

    def quantify(*args)
      self.quantifier = Quantifier.new(*args)
    end

    def unquantified_clone
      clone.tap { |exp| exp.quantifier = nil }
    end

    # Deprecated. Prefer `#repetitions` which has a more uniform interface.
    def quantity
      return [nil,nil] unless quantified?
      [quantifier.min, quantifier.max]
    end

    def repetitions
      return 1..1 unless quantified?
      min = quantifier.min
      max = quantifier.max < 0 ? Float::INFINITY : quantifier.max
      range = min..max
      # fix Range#minmax on old Rubies - https://bugs.ruby-lang.org/issues/15807
      if RUBY_VERSION.to_f < 2.7
        range.define_singleton_method(:minmax) { [min, max] }
      end
      range
    end

    def greedy?
      quantified? and quantifier.greedy?
    end

    def reluctant?
      quantified? and quantifier.reluctant?
    end
    alias :lazy? :reluctant?

    def possessive?
      quantified? and quantifier.possessive?
    end

    def to_h
      {
        type:              type,
        token:             token,
        text:              to_s(:base),
        starts_at:         ts,
        length:            full_length,
        level:             level,
        set_level:         set_level,
        conditional_level: conditional_level,
        options:           options,
        quantifier:        quantified? ? quantifier.to_h : nil,
      }
    end
    alias :attributes :to_h
  end
end
