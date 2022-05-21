module Regexp::Syntax
  module Token
    module Meta
      Basic    = %i[dot]
      Extended = Basic + %i[alternation]

      All = Extended
      Type = :meta
    end

    Map[Meta::Type] = Meta::All
  end
end
