# -*- encoding: utf-8 -*-
# stub: rubocop 0.93.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop".freeze
  s.version = "0.93.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rubocop-hq/rubocop/issues", "changelog_uri" => "https://github.com/rubocop-hq/rubocop/blob/master/CHANGELOG.md", "documentation_uri" => "https://docs.rubocop.org/rubocop/0.93/", "homepage_uri" => "https://rubocop.org/", "source_code_uri" => "https://github.com/rubocop-hq/rubocop/" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bozhidar Batsov".freeze, "Jonas Arvidsson".freeze, "Yuji Nakayama".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-10-12"
  s.description = "    RuboCop is a Ruby code style checking and code formatting tool.\n    It aims to enforce the community-driven Ruby Style Guide.\n".freeze
  s.email = "rubocop@googlegroups.com".freeze
  s.executables = ["rubocop".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze, "exe/rubocop".freeze]
  s.homepage = "https://github.com/rubocop-hq/rubocop".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Automatic Ruby code style checking tool.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parallel>.freeze, ["~> 1.10"])
      s.add_runtime_dependency(%q<parser>.freeze, [">= 2.7.1.5"])
      s.add_runtime_dependency(%q<rainbow>.freeze, [">= 2.2.2", "< 4.0"])
      s.add_runtime_dependency(%q<regexp_parser>.freeze, [">= 1.8"])
      s.add_runtime_dependency(%q<rexml>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rubocop-ast>.freeze, [">= 0.6.0"])
      s.add_runtime_dependency(%q<ruby-progressbar>.freeze, ["~> 1.7"])
      s.add_runtime_dependency(%q<unicode-display_width>.freeze, [">= 1.4.0", "< 2.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.15.0", "< 3.0"])
    else
      s.add_dependency(%q<parallel>.freeze, ["~> 1.10"])
      s.add_dependency(%q<parser>.freeze, [">= 2.7.1.5"])
      s.add_dependency(%q<rainbow>.freeze, [">= 2.2.2", "< 4.0"])
      s.add_dependency(%q<regexp_parser>.freeze, [">= 1.8"])
      s.add_dependency(%q<rexml>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop-ast>.freeze, [">= 0.6.0"])
      s.add_dependency(%q<ruby-progressbar>.freeze, ["~> 1.7"])
      s.add_dependency(%q<unicode-display_width>.freeze, [">= 1.4.0", "< 2.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.15.0", "< 3.0"])
    end
  else
    s.add_dependency(%q<parallel>.freeze, ["~> 1.10"])
    s.add_dependency(%q<parser>.freeze, [">= 2.7.1.5"])
    s.add_dependency(%q<rainbow>.freeze, [">= 2.2.2", "< 4.0"])
    s.add_dependency(%q<regexp_parser>.freeze, [">= 1.8"])
    s.add_dependency(%q<rexml>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-ast>.freeze, [">= 0.6.0"])
    s.add_dependency(%q<ruby-progressbar>.freeze, ["~> 1.7"])
    s.add_dependency(%q<unicode-display_width>.freeze, [">= 1.4.0", "< 2.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.15.0", "< 3.0"])
  end
end
