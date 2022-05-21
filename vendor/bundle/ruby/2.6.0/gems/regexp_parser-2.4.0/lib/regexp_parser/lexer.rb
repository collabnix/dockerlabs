# A very thin wrapper around the scanner that breaks quantified literal runs,
# collects emitted tokens into an array, calculates their nesting depth, and
# normalizes tokens for the parser, and checks if they are implemented by the
# given syntax flavor.
class Regexp::Lexer

  OPENING_TOKENS = %i[
    capture passive lookahead nlookahead lookbehind nlookbehind
    atomic options options_switch named absence
  ].freeze

  CLOSING_TOKENS = %i[close].freeze

  CONDITION_TOKENS = %i[condition condition_close].freeze

  def self.lex(input, syntax = "ruby/#{RUBY_VERSION}", options: nil, &block)
    new.lex(input, syntax, options: options, &block)
  end

  def lex(input, syntax = "ruby/#{RUBY_VERSION}", options: nil, &block)
    syntax = Regexp::Syntax.for(syntax)

    self.tokens = []
    self.nesting = 0
    self.set_nesting = 0
    self.conditional_nesting = 0
    self.shift = 0

    last = nil
    Regexp::Scanner.scan(input, options: options) do |type, token, text, ts, te|
      type, token = *syntax.normalize(type, token)
      syntax.check! type, token

      ascend(type, token)

      if type == :quantifier and last
        break_literal(last)        if last.type == :literal
        break_codepoint_list(last) if last.token == :codepoint_list
      end

      current = Regexp::Token.new(type, token, text, ts + shift, te + shift,
                                  nesting, set_nesting, conditional_nesting)

      current = merge_condition(current) if type == :conditional and
        CONDITION_TOKENS.include?(token)

      last.next = current if last
      current.previous = last if last

      tokens << current
      last = current

      descend(type, token)
    end

    if block_given?
      tokens.map { |t| block.call(t) }
    else
      tokens
    end
  end

  class << self
    alias :scan :lex
  end

  private

  attr_accessor :tokens, :nesting, :set_nesting, :conditional_nesting, :shift

  def ascend(type, token)
    case type
    when :group, :assertion
      self.nesting = nesting - 1 if CLOSING_TOKENS.include?(token)
    when :set
      self.set_nesting = set_nesting - 1 if token == :close
    when :conditional
      self.conditional_nesting = conditional_nesting - 1 if token == :close
    end
  end

  def descend(type, token)
    case type
    when :group, :assertion
      self.nesting = nesting + 1 if OPENING_TOKENS.include?(token)
    when :set
      self.set_nesting = set_nesting + 1 if token == :open
    when :conditional
      self.conditional_nesting = conditional_nesting + 1 if token == :open
    end
  end

  # called by scan to break a literal run that is longer than one character
  # into two separate tokens when it is followed by a quantifier
  def break_literal(token)
    lead, last, _ = token.text.partition(/.\z/mu)
    return if lead.empty?

    tokens.pop
    tokens << Regexp::Token.new(:literal, :literal, lead,
              token.ts, (token.te - last.length),
              nesting, set_nesting, conditional_nesting)
    tokens << Regexp::Token.new(:literal, :literal, last,
              (token.ts + lead.length), token.te,
              nesting, set_nesting, conditional_nesting)
  end

  def break_codepoint_list(token)
    lead, _, tail = token.text.rpartition(' ')
    return if lead.empty?

    tokens.pop
    tokens << Regexp::Token.new(:escape, :codepoint_list, lead + '}',
              token.ts, (token.te - tail.length),
              nesting, set_nesting, conditional_nesting)
    tokens << Regexp::Token.new(:escape, :codepoint_list, '\u{' + tail,
              (token.ts + lead.length + 1), (token.te + 3),
              nesting, set_nesting, conditional_nesting)

    self.shift = shift + 3 # one space less, but extra \, u, {, and }
  end

  def merge_condition(current)
    last = tokens.pop
    Regexp::Token.new(:conditional, :condition, last.text + current.text,
      last.ts, current.te, nesting, set_nesting, conditional_nesting)
  end

end # module Regexp::Lexer
