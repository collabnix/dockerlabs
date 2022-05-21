# -*- encoding: utf-8 -*-
# stub: html-proofer 3.19.4 ruby lib

Gem::Specification.new do |s|
  s.name = "html-proofer".freeze
  s.version = "3.19.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "funding_uri" => "https://github.com/sponsors/gjtorikian/", "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Garen Torikian".freeze]
  s.date = "2022-05-19"
  s.description = "Test your rendered HTML files to make sure they're accurate.".freeze
  s.email = ["gjtorikian@gmail.com".freeze]
  s.executables = ["htmlproofer".freeze]
  s.files = ["bin/htmlproofer".freeze]
  s.homepage = "https://github.com/gjtorikian/html-proofer".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.6.0".freeze, "< 4.0".freeze])
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "A set of tests to validate your HTML output. These tests check if your image references are legitimate, if they have alt tags, if your internal links are working, and so on. It's intended to be an all-in-one checker for your documentation output.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_runtime_dependency(%q<mercenary>.freeze, ["~> 0.3"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.13"])
      s.add_runtime_dependency(%q<parallel>.freeze, ["~> 1.10"])
      s.add_runtime_dependency(%q<rainbow>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<yell>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<awesome_print>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop-standard>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 2.9"])
    else
      s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_dependency(%q<mercenary>.freeze, ["~> 0.3"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.13"])
      s.add_dependency(%q<parallel>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rainbow>.freeze, ["~> 3.0"])
      s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_dependency(%q<yell>.freeze, ["~> 2.0"])
      s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
      s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop-performance>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop-standard>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.8"])
      s.add_dependency(%q<vcr>.freeze, ["~> 2.9"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<mercenary>.freeze, ["~> 0.3"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.13"])
    s.add_dependency(%q<parallel>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rainbow>.freeze, ["~> 3.0"])
    s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
    s.add_dependency(%q<yell>.freeze, ["~> 2.0"])
    s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-performance>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-standard>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.8"])
    s.add_dependency(%q<vcr>.freeze, ["~> 2.9"])
  end
end
