module Regexp::Expression
  class PosixClass < Regexp::Expression::Base
    def negative?
      type == :nonposixclass
    end

    def name
      token.to_s
    end
  end
end
