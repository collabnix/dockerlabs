module Regexp::Expression
  class Subexpression < Regexp::Expression::Base

    # Traverses the subexpression (depth-first, pre-order) and calls the given
    # block for each expression with three arguments; the traversal event,
    # the expression, and the index of the expression within its parent.
    #
    # The event argument is passed as follows:
    #
    # - For subexpressions, :enter upon entering the subexpression, and
    #   :exit upon exiting it.
    #
    # - For terminal expressions, :visit is called once.
    #
    # Returns self.
    def traverse(include_self = false, &block)
      return enum_for(__method__, include_self) unless block_given?

      block.call(:enter, self, 0) if include_self

      each_with_index do |exp, index|
        if exp.terminal?
          block.call(:visit, exp, index)
        else
          block.call(:enter, exp, index)
          exp.traverse(&block)
          block.call(:exit, exp, index)
        end
      end

      block.call(:exit, self, 0) if include_self

      self
    end
    alias :walk :traverse

    # Iterates over the expressions of this expression as an array, passing
    # the expression and its index within its parent to the given block.
    def each_expression(include_self = false)
      return enum_for(__method__, include_self) unless block_given?

      traverse(include_self) do |event, exp, index|
        yield(exp, index) unless event == :exit
      end
    end

    # Returns a new array with the results of calling the given block once
    # for every expression. If a block is not given, returns an array with
    # each expression and its level index as an array.
    def flat_map(include_self = false)
      result = []

      each_expression(include_self) do |exp, index|
        if block_given?
          result << yield(exp, index)
        else
          result << [exp, index]
        end
      end

      result
    end
  end
end
