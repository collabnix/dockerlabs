## [Unreleased]

## [2.4.0] - 2022-05-09 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed interpretation of `+` and `?` after interval quantifiers (`{n,n}`)
  - they used to be treated as reluctant or possessive mode indicators
  - however, Ruby does not support these modes for interval quantifiers
  - they are now treated as chained quantifiers instead, as Ruby does it
  - c.f. [#3](https://github.com/ammar/regexp_parser/issues/3)
- fixed `Expression::Base#nesting_level` for some tree rewrite cases
  - e.g. the alternatives in `/a|[b]/` had an inconsistent nesting_level
- fixed `Scanner` accepting invalid posix classes, e.g. `[[:foo:]]`
  - they raise a `SyntaxError` when used in a Regexp, so could only be passed as String
  - they now raise a `Regexp::Scanner::ValidationError` in the `Scanner`

### Added

- added `Expression::Base#==` for (deep) comparison of expressions
- added `Expression::Base#parts`
  - returns the text elements and subexpressions of an expression
  - e.g. `parse(/(a)/)[0].parts # => ["(", #<Literal @text="a"...>, ")"]`
- added `Expression::Base#te` (a.k.a. token end index)
  - `Expression::Subexpression` always had `#te`, only terminal nodes lacked it so far
- made some `Expression::Base` methods available on `Quantifier` instances, too
  - `#type`, `#type?`, `#is?`, `#one_of?`, `#options`, `#terminal?`
  - `#base_length`, `#full_length`, `#starts_at`, `#te`, `#ts`, `#offset`
  - `#conditional_level`, `#level`, `#nesting_level` , `#set_level`
  - this allows a more unified handling with `Expression::Base` instances
- allowed `Quantifier#initialize` to take a token and options Hash like other nodes
- added a deprecation warning for initializing Quantifiers with 4+ arguments:

    Calling `Expression::Base#quantify` or `Quantifier.new` with 4+ arguments
    is deprecated.

    It will no longer be supported in regexp_parser v3.0.0.

    Please pass a Regexp::Token instead, e.g. replace `type, text, min, max, mode`
    with `::Regexp::Token.new(:quantifier, type, text)`. min, max, and mode
    will be derived automatically.

    This is consistent with how Expression::Base instances are created.


## [2.3.1] - 2022-04-24 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- removed five inexistent unicode properties from `Syntax#features`
  - these were never supported by Ruby or the `Regexp::Scanner`
  - thanks to [Markus Schirp](https://github.com/mbj) for the report

## [2.3.0] - 2022-04-08 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- improved parsing performance through `Syntax` refactoring
  - instead of fresh `Syntax` instances, pre-loaded constants are now re-used
  - this approximately doubles the parsing speed for simple regexps
- added methods to `Syntax` classes to show relative feature sets
  - e.g. `Regexp::Syntax::V3_2_0.added_features`
- support for new unicode properties of Ruby 3.2 / Unicode 14.0

## [2.2.1] - 2022-02-11 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed Syntax version of absence groups (`(?~...)`)
  - the lexer accepted them for any Ruby version
  - now they are only recognized for Ruby >= 2.4.1 in which they were introduced
- reduced gem size by excluding specs from package
- removed deprecated `test_files` gemspec setting
- no longer depend on `yaml`/`psych` (except for Ruby <= 2.4)
- no longer depend on `set`
  - `set` was removed from the stdlib and made a standalone gem as of Ruby 3
  - this made it a hidden/undeclared dependency of `regexp_parser`

## [2.2.0] - 2021-12-04 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- added support for 13 new unicode properties introduced in Ruby 3.1.0

## [2.1.1] - 2021-02-23 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed `NameError` when requiring only `'regexp_parser/scanner'` in v2.1.0
  * thanks to [Jared White and Sam Ruby](https://github.com/ruby2js/ruby2js) for the report

## [2.1.0] - 2021-02-22 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- common ancestor for all scanning/parsing/lexing errors
  * `Regexp::Parser::Error` can now be rescued as a catch-all
  * the following errors (and their many descendants) now inherit from it:
    - `Regexp::Expression::Conditional::TooManyBranches`
    - `Regexp::Parser::ParserError`
    - `Regexp::Scanner::ScannerError`
    - `Regexp::Scanner::ValidationError`
    - `Regexp::Syntax::SyntaxError`
  * it replaces `ArgumentError` in some rare cases (`Regexp::Parser.parse('?')`)
  * thanks to [sandstrom](https://github.com/sandstrom) for the cue

### Fixed

- fixed scanning of whole-pattern recursion calls `\g<0>` and `\g'0'`
  * a regression in v2.0.1 had caused them to be scanned as literals
- fixed scanning of some backreference and subexpression call edge cases
  * e.g. `\k<+1>`, `\g<x-1>`
- fixed tokenization of some escapes in character sets
  * `.`, `|`, `{`, `}`, `(`, `)`, `^`, `$`, `?`, `+`, `*`
  * all of these correctly emitted `#type` `:literal` and `#token` `:literal` if *not* escaped
  * if escaped, they emitted e.g. `#type` `:escape` and `#token` `:group_open` for `[\(]`
  * the escaped versions now correctly emit `#type` `:escape` and `#token` `:literal`
- fixed handling of control/metacontrol escapes in character sets
  * e.g. `[\cX]`, `[\M-\C-X]`
  * they were misread as bunch of individual literals, escapes, and ranges
- fixed some cases where calling `#dup`/`#clone` on expressions led to shared state

## [2.0.3] - 2020-12-28 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed error when scanning some unlikely and redundant but valid charset patterns
  * e.g. `/[[.a-b.]]/`, `/[[=e=]]/`,
- fixed ancestry of some error classes related to syntax version lookup
  * `NotImplementedError`, `InvalidVersionNameError`, `UnknownSyntaxNameError`
  * they now correctly inherit from `Regexp::Syntax::SyntaxError` instead of Rubys `::SyntaxError`

## [2.0.2] - 2020-12-25 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed `FrozenError` when calling `#to_s` on a frozen `Group::Passive`
  * thanks to [Daniel Gollahon](https://github.com/dgollahon)

## [2.0.1] - 2020-12-20 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed error when scanning some group names
  * this affected names containing hyphens, digits or multibyte chars, e.g. `/(?<a1>a)/`
  * thanks to [Daniel Gollahon](https://github.com/dgollahon) for the report
- fixed error when scanning hex escapes with just one hex digit
  * e.g. `/\x0A/` was scanned correctly, but the equivalent `/\xA/` was not
  * thanks to [Daniel Gollahon](https://github.com/dgollahon) for the report

## [2.0.0] - 2020-11-25 - [Janosch Müller](mailto:janosch84@gmail.com)

### Changed

- some methods that used to return byte-based indices now return char-based indices
  * the returned values have only changed for Regexps that contain multibyte chars
  * this is only a breaking change if you used such methods directly AND relied on them pointing to bytes
  * affected methods:
  * `Regexp::Token` `#length`, `#offset`, `#te`, `#ts`
  * `Regexp::Expression::Base` `#full_length`, `#offset`, `#starts_at`, `#te`, `#ts`
  * thanks to [Akinori MUSHA](https://github.com/knu) for the report
- removed some deprecated methods/signatures
  * these are rarely used and have been showing deprecation warnings for a long time
  * `Regexp::Expression::Subexpression.new` with 3 arguments
  * `Regexp::Expression::Root.new` without a token argument
  * `Regexp::Expression.parsed`

### Added

- `Regexp::Expression::Base#base_length`
  * returns the character count of an expression body, ignoring any quantifier
- pragmatic, experimental support for chained quantifiers
  * e.g.: `/^a{10}{4,6}$/` matches exactly 40, 50 or 60 `a`s
  * successive quantifiers used to be silently dropped by the parser
  * they are now wrapped with passive groups as if they were written `(?:a{10}){4,6}`
  * thanks to [calfeld](https://github.com/calfeld) for reporting this a while back

### Fixed

- incorrect encoding output for non-ascii comments
  * this led to a crash when calling `#to_s` on parse results containing such comments
  * thanks to [Michael Glass](https://github.com/michaelglass) for the report
- some crashes when scanning contrived patterns such as `'\😋'`

### [1.8.2] - 2020-10-11 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fix `FrozenError` in `Expression::Base#repetitions` on Ruby 3.0
  * thanks to [Thomas Walpole](https://github.com/twalpole)
- removed "unknown future version" warning on Ruby 3.0

### [1.8.1] - 2020-09-28 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- fixed scanning of comment-like text in normal mode
  * this was an old bug, but had become more prevalent in v1.8.0
  * thanks to [Tietew](https://github.com/Tietew) for the report
- specified correct minimum Ruby version in gemspec
  * it said 1.9 but really required 2.0 as of v1.8.0

### [1.8.0] - 2020-09-20 - [Janosch Müller](mailto:janosch84@gmail.com)

### Changed

- dropped support for running on Ruby 1.9.x

### Added

- regexp flags can now be passed when parsing a `String` as regexp body
  * see the [README](/README.md#usage) for details
  * thanks to [Owen Stephens](https://github.com/owst)
- bare occurrences of `\g` and `\k` are now allowed and scanned as literal escapes
  * matches Onigmo behavior
  * thanks for the report to [Marc-André Lafortune](https://github.com/marcandre)

### Fixed

- fixed parsing comments without preceding space or trailing newline in x-mode
  * thanks to [Owen Stephens](https://github.com/owst)

### [1.7.1] - 2020-06-07 - [Ammar Ali](mailto:ammarabuali@gmail.com)

### Fixed

- Support for literals that include the unescaped delimiters `{`, `}`, and `]`. These
  delimiters are informally supported by various regexp engines.

### [1.7.0] - 2020-02-23 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- `Expression::Base#each_expression` and `#traverse` can now be called without a block
  * this returns an `Enumerator` and allows chaining, e.g. `each_expression.select`
  * thanks to [Masataka Kuwabara](https://github.com/pocke)

### Fixed

- `MatchLength#each` no longer ignores the given `limit:` when called without a block

### [1.6.0] - 2019-06-16 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- Added support for 16 new unicode properties introduced in Ruby 2.6.2 and 2.6.3

### [1.5.1] - 2019-05-23 - [Janosch Müller](mailto:janosch84@gmail.com)

### Fixed

- Fixed `#options` (and thus `#i?`, `#u?` etc.) not being set for some expressions:
  * this affected posix classes as well as alternation, conditional, and intersection branches
  * `#options` was already correct for all child expressions of such branches
  * this only made an operational difference for posix classes as they respect encoding flags
- Fixed `#options` not respecting all negative options in weird cases like '(?u-m-x)'
- Fixed `Group#option_changes` not accounting for indirectly disabled (overridden) encoding flags
- Fixed `Scanner` allowing negative encoding options if there were no positive options, e.g. '(?-u)'
- Fixed `ScannerError` for some valid meta/control sequences such as '\\C-\\\\'
- Fixed `Expression::Base#match` and `#=~` not working with a single argument

### [1.5.0] - 2019-05-14 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- Added `#referenced_expression` for backrefs, subexp calls and conditionals
  * returns the `Group` expression that is being referenced via name or number
- Added `Expression::Base#repetitions`
  * returns a `Range` of allowed repetitions (`1..1` if there is no quantifier)
  * like `#quantity` but with a more uniform interface
- Added `Expression::Base#match_length`
  * allows to inspect and iterate over String lengths matched by the Expression

### Fixed

- Fixed `Expression::Base#clone` "direction"
  * it used to dup ivars onto the callee, leaving only the clone referencing the original objects
  * this will affect you if you call `#eql?`/`#equal?` on expressions or use them as Hash keys
- Fixed `#clone` results for `Sequences`, e.g. alternations and conditionals
  * the inner `#text` was cloned onto the `Sequence` and thus duplicated
  * e.g. `Regexp::Parser.parse(/(a|bc)/).clone.to_s # => (aa|bcbc)`
- Fixed inconsistent `#to_s` output for `Sequences`
  * it used to return only the "specific" text, e.g. "|" for an alternation
  * now it includes nested expressions as it does for all other `Subexpressions`
- Fixed quantification of codepoint lists with more than one entry (`\u{62 63 64}+`)
  * quantifiers apply only to the last entry, so this token is now split up if quantified

### [1.4.0] - 2019-04-02 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- Added support for 19 new unicode properties introduced in Ruby 2.6.0

### [1.3.0] - 2018-11-14 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- `Syntax#features` returns a `Hash` of all types and tokens supported by a given `Syntax`

### Fixed

- Thanks to [Akira Matsuda](https://github.com/amatsuda)
  * eliminated warning "assigned but unused variable - testEof"

## [1.2.0] - 2018-09-28 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- `Subexpression` (branch node) includes `Enumerable`, allowing to `#select` children etc.

### Fixed

- Fixed missing quantifier in `Conditional::Expression` methods `#to_s`, `#to_re`
- `Conditional::Condition` no longer lives outside the recursive `#expressions` tree
  - it used to be the only expression stored in a custom ivar, complicating traversal
  - its setter and getter (`#condition=`, `#condition`) still work as before

## [1.1.0] - 2018-09-17 - [Janosch Müller](mailto:janosch84@gmail.com)

### Added

- Added `Quantifier` methods `#greedy?`, `#possessive?`, `#reluctant?`/`#lazy?`
- Added `Group::Options#option_changes`
  - shows the options enabled or disabled by the given options group
  - as with all other expressions, `#options` shows the overall active options
- Added `Conditional#reference` and `Condition#reference`, indicating the determinative group
- Added `Subexpression#dig`, acts like [`Array#dig`](http://ruby-doc.org/core-2.5.0/Array.html#method-i-dig)

### Fixed

- Fixed parsing of quantified conditional expressions (quantifiers were assigned to the wrong expression)
- Fixed scanning and parsing of forward-referring subexpression calls (e.g. `\g<+1>`)
- `Root` and `Sequence` expressions now support the same constructor signature as all other expressions

## [1.0.0] - 2018-09-01 - [Janosch Müller](mailto:janosch84@gmail.com)

This release includes several breaking changes, mostly to character sets, #map and properties.

### Changed

- Changed handling of sets (a.k.a. character classes or "bracket expressions")
  * see PR [#55](https://github.com/ammar/regexp_parser/pull/55) / issue [#47](https://github.com/ammar/regexp_parser/issues/47) for details
  * sets are now parsed to expression trees like other nestable expressions
  * `#scan` now emits the same tokens as outside sets (no longer `:set, :member`)
  * `CharacterSet#members` has been removed
  * new `Range` and `Intersection` classes represent corresponding syntax features
  * a new `PosixClass` expression class represents e.g. `[[:ascii:]]`
    * `PosixClass` instances behave like `Property` ones, e.g. support `#negative?`
    * `#scan` emits `:(non)posixclass, :<type>` instead of `:set, :char_(non)<type>`
- Changed `Subexpression#map` to act like regular `Enumerable#map`
  * the old behavior is available as `Subexpression#flat_map`
  * e.g. `parse(/[a]/).map(&:to_s) == ["[a]"]`; used to be `["[a]", "a"]`
- Changed expression emissions for some escape sequences
  * `EscapeSequence::Codepoint`, `CodepointList`, `Hex` and `Octal` are now all used
  * they already existed, but were all parsed as `EscapeSequence::Literal`
  * e.g. `\x97` is now `EscapeSequence::Hex` instead of `EscapeSequence::Literal`
- Changed naming of many property tokens (emitted for `\p{...}`)
  * if you work with these tokens, see PR [#56](https://github.com/ammar/regexp_parser/pull/56) for details
  * e.g. `:punct_dash` is now `:dash_punctuation`
- Changed `(?m)` and the likes to emit as `:options_switch` token (@4ade4d1)
  * allows differentiating from group-local `:options`, e.g. `(?m:.)`
- Changed name of `Backreference::..NestLevel` to `..RecursionLevel` (@4184339)
- Changed `Backreference::Number#number` from `String` to `Integer` (@40a2231)

### Added

- Added support for all previously missing properties (about 250)
- Added `Expression::UnicodeProperty#shortcut` (e.g. returns "m" for `\p{mark}`)
- Added `#char(s)` and `#codepoint(s)` methods to all `EscapeSequence` expressions
- Added `#number`/`#name`/`#recursion_level` to all backref/call expressions (@174bf21)
- Added `#number` and `#number_at_level` to capturing group expressions (@40a2231)

### Fixed

- Fixed Ruby version mapping of some properties
- Fixed scanning of some property spellings, e.g. with dashes
- Fixed some incorrect property alias normalizations
- Fixed scanning of codepoint escapes with 6 digits (e.g. `\u{10FFFF}`)
- Fixed scanning of `\R` and `\X` within sets; they act as literals there

## [0.5.0] - 2018-04-29 - [Janosch Müller](mailto:janosch84@gmail.com)

### Changed

- Changed handling of Ruby versions (PR [#53](https://github.com/ammar/regexp_parser/pull/53))
  * New Ruby versions are now supported by default
  * Some deep-lying APIs have changed, which should not affect most users:
    * `Regexp::Syntax::VERSIONS` is gone
    * Syntax version names have changed from `Regexp::Syntax::Ruby::Vnnn`
      to `Regexp::Syntax::Vn_n_n`
    * Syntax version classes for Ruby versions without regex feature changes
      are no longer predefined and are now only created on demand / lazily
    * `Regexp::Syntax::supported?` returns true for any argument >= 1.8.6

### Fixed

- Fixed some use cases of Expression methods #strfregexp and #to_h (@e738107)

### Added

- Added full signature support to collection methods of Expressions (@aa7c55a)

## [0.4.13] - 2018-04-04 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Added ruby version files for 2.2.10 and 2.3.7

## [0.4.12] - 2018-03-30 - [Janosch Müller](mailto:janosch84@gmail.com)

- Added ruby version files for 2.4.4 and 2.5.1

## [0.4.11] - 2018-03-04 - [Janosch Müller](mailto:janosch84@gmail.com)

- Fixed UnknownSyntaxNameError introduced in v0.4.10 if
  the gems parent dir tree included a 'ruby' dir

## [0.4.10] - 2018-03-04 - [Janosch Müller](mailto:janosch84@gmail.com)

- Added ruby version file for 2.6.0
- Added support for Emoji properties (available in Ruby since 2.5.0)
- Added support for XPosixPunct and Regional_Indicator properties
- Fixed parsing of Unicode 6.0 and 7.0 script properties
- Fixed parsing of the special Assigned property
- Fixed scanning of InCyrillic_Supplement property

## [0.4.9] - 2017-12-25 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Added ruby version file for 2.5.0

## [0.4.8] - 2017-12-18 - [Janosch Müller](mailto:janosch84@gmail.com)

- Added ruby version files for 2.2.9, 2.3.6, and 2.4.3

## [0.4.7] - 2017-10-15 - [Janosch Müller](mailto:janosch84@gmail.com)

- Fixed a thread safety issue (issue #45)
- Some public class methods that were only reliable for
  internal use are now private instance methods (PR #46)
- Improved the usefulness of Expression::Base#options (issue #43) -
  #options and derived methods such as #i?, #m? and #x? are now
  defined for all Expressions that are affected by such flags.
- Fixed scanning of whitespace following (?x) (commit 5c94bd2)
- Fixed a Parser bug where the #number attribute of traditional
  numerical backreferences was not set correctly (commit 851b620)

## [0.4.6] - 2017-09-18 - [Janosch Müller](mailto:janosch84@gmail.com)

- Added Parser support for hex escapes in sets (PR #36)
- Added Parser support for octal escapes (PR #37)
- Added support for cluster types \R and \X (PR #38)
- Added support for more metacontrol notations (PR #39)

## [0.4.5] - 2017-09-17 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [Janosch Müller](https://github.com/janosch-x):
  * Support ruby 2.2.7 (PR #42)
- Added ruby version files for 2.2.8, 2.3.5, and 2.4.2

## [0.4.4] - 2017-07-10 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [Janosch Müller](https://github.com/janosch-x):
  * Add support for new absence operator (PR #33)
- Thanks to [Bartek Bułat](https://github.com/barthez):
  * Add support for Ruby 2.3.4 version (PR #40)

## [0.4.3] - 2017-03-24 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Added ruby version file for 2.4.1

## [0.4.2] - 2017-01-10 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [Janosch Müller](https://github.com/janosch-x):
  * Support ruby 2.4 (PR #30)
  * Improve codepoint handling (PR #27)

## [0.4.1] - 2016-11-22 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Updated ruby version file for 2.3.3

## [0.4.0] - 2016-11-20 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Added Syntax.supported? method
- Updated ruby versions for latest releases; 2.1.10, 2.2.6, and 2.3.2

## [0.3.6] - 2016-06-08 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [John Backus](https://github.com/backus):
  * Remove warnings (PR #26)

## [0.3.5] - 2016-05-30 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [John Backus](https://github.com/backus):
  * Fix parsing of /\xFF/n (hex:escape) (PR #24)

## [0.3.4] - 2016-05-25 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [John Backus](https://github.com/backus):
  * Fix warnings (PR #19)
- Thanks to [Dana Scheider](https://github.com/danascheider):
  * Correct error in README (PR #20)
- Fixed mistyped \h and \H character types (issue #21)
- Added ancestry syntax files for latest rubies (issue #22)

## [0.3.3] - 2016-04-26 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Thanks to [John Backus](https://github.com/backus):
  * Fixed scanning of zero length comments (PR #12)
  * Fixed missing escape:codepoint_list syntax token (PR #14)
  * Fixed to_s for modified interval quantifiers (PR #17)
- Added a note about MRI implementation quirks to Scanner section

## [0.3.2] - 2016-01-01 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Updated ruby versions for latest releases; 2.1.8, 2.2.4, and 2.3.0
- Fixed class name for UnknownSyntaxNameError exception
- Added UnicodeBlocks support to the parser.
- Added UnicodeBlocks support to the scanner.
- Added expand_members method to CharacterSet, returns traditional
  or unicode property forms of shothands (\d, \W, \s, etc.)
- Improved meaning and output of %t and %T in strfregexp.
- Added syntax versions for ruby 2.1.4 and 2.1.5 and updated
  latest 2.1 version.
- Added to_h methods to Expression, Subexpression, and Quantifier.
- Added traversal methods; traverse, each_expression, and map.
- Added token/type test methods; type?, is?, and one_of?
- Added printing method strfregexp, inspired by strftime.
- Added scanning and parsing of free spacing (x mode) expressions.
- Improved handling of inline options (?mixdau:...)
- Added conditional expressions. Ruby 2.0.
- Added keep (\K) markers. Ruby 2.0.
- Added d, a, and u options. Ruby 2.0.
- Added missing meta sequences to the parser. They were supported by the scanner only.
- Renamed Lexer's method to lex, added an alias to the old name (scan)
- Use #map instead of #each to run the block in Lexer.lex.
- Replaced VERSION.yml file with a constant.
- Updated README
- Update tokens and scanner with new additions in Unicode 7.0.

## [0.1.6] - 2014-10-06 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Fixed test and gem building rake tasks and extracted the gem
  specification from the Rakefile into a .gemspec file.
- Added syntax files for missing ruby 2.x versions. These do not add
  extra syntax support, they just make the gem work with the newer
  ruby versions.
- Added .travis.yml to project root.
- README:
  - Removed note purporting runtime support for ruby 1.8.6.
  - Added a section identifying the main unsupported syntax features.
  - Added sections for Testing and Building
  - Added badges for gem version, Travis CI, and code climate.
- Updated README, fixing broken examples, and converting it from a rdoc file to Github's flavor of Markdown.
- Fixed a parser bug where an alternation sequence that contained nested expressions was incorrectly being appended to the parent expression when the nesting was exited. e.g. in /a|(b)c/, c was appended to the root.

- Fixed a bug where character types were not being correctly scanned within character sets. e.g. in [\d], two tokens were scanned; one for the backslash '\' and one for the 'd'

## [0.1.5] - 2014-01-14 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Correct ChangeLog.
- Added syntax stubs for ruby versions 2.0 and 2.1
- Added clone methods for deep copying expressions.
- Added optional format argument for to_s on expressions to return the text of the expression with (:full, the default) or without (:base) its quantifier.
- Renamed the :beginning_of_line and :end_of_line tokens to :bol and :eol.
- Fixed a bug where alternations with more than two alternatives and one of them ending in a group were being incorrectly nested.
- Improved EOF handling in general and especially from sequences like hex and control escapes.
- Fixed a bug where named groups with an empty name would return a blank token [].
- Fixed a bug where member of a parent set where being added to its last subset.
- Various code cleanups in scanner.rl
- Fixed a few mutable string bugs by calling dup on the originals.
- Made ruby 1.8.6 the base for all 1.8 syntax, and the 1.8 name a pointer to the latest (1.8.7 at this time)
- Removed look-behind assertions (positive and negative) from 1.8 syntax
- Added control (\cc and \C-c) and meta (\M-c) escapes to 1.8 syntax
- The default syntax is now the one of the running ruby version in both the lexer and the parser.

## [0.1.0] - 2010-11-21 - [Ammar Ali](mailto:ammarabuali@gmail.com)

- Initial release
