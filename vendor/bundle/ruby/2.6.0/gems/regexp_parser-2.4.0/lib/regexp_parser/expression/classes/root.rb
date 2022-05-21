module Regexp::Expression
  class Root < Regexp::Expression::Subexpression
    def self.build(options = {})
      new(build_token, options)
    end

    def self.build_token
      Regexp::Token.new(:expression, :root, '', 0)
    end
  end
end
