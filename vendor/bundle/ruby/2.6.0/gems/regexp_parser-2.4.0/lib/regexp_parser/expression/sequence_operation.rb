module Regexp::Expression
  # abstract class
  class SequenceOperation < Regexp::Expression::Subexpression
    alias :sequences :expressions
    alias :operands :expressions
    alias :operator :text

    def starts_at
      expressions.first.starts_at
    end
    alias :ts :starts_at

    def <<(exp)
      expressions.last << exp
    end

    def add_sequence(active_opts = {})
      self.class::OPERAND.add_to(self, {}, active_opts)
    end

    def parts
      intersperse(expressions, text.dup)
    end
  end
end
