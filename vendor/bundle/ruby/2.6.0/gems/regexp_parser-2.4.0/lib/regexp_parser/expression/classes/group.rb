module Regexp::Expression
  module Group
    class Base < Regexp::Expression::Subexpression
      def parts
        [text.dup, *expressions, ')']
      end

      def capturing?; false end

      def comment?; false end
    end

    class Passive < Group::Base
      attr_writer :implicit

      def initialize(*)
        @implicit = false
        super
      end

      def parts
        if implicit?
          expressions
        else
          super
        end
      end

      def implicit?
        @implicit
      end
    end

    class Absence < Group::Base; end
    class Atomic  < Group::Base; end
    class Options < Group::Base
      attr_accessor :option_changes

      def initialize_copy(orig)
        self.option_changes = orig.option_changes.dup
        super
      end
    end

    class Capture < Group::Base
      attr_accessor :number, :number_at_level
      alias identifier number

      def capturing?; true end
    end

    class Named < Group::Capture
      attr_reader :name
      alias identifier name

      def initialize(token, options = {})
        @name = token.text[3..-2]
        super
      end

      def initialize_copy(orig)
        @name = orig.name.dup
        super
      end
    end

    class Comment < Group::Base
      def parts
        [text.dup]
      end

      def comment?; true end
    end
  end

  module Assertion
    class Base < Regexp::Expression::Group::Base; end

    class Lookahead           < Assertion::Base; end
    class NegativeLookahead   < Assertion::Base; end

    class Lookbehind          < Assertion::Base; end
    class NegativeLookbehind  < Assertion::Base; end
  end
end
