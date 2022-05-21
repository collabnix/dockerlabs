# -*- encoding: utf-8 -*-
require File.expand_path('../lib/w3c_validators/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Dunae"]
  gem.summary       = "A Ruby wrapper for the World Wide Web Consortium’s online validation services."
  gem.homepage      = "https://github.com/w3c-validators/w3c_validators"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test}/*`.split("\n")
  gem.name          = "w3c_validators"
  gem.require_paths = ["lib"]
  gem.version       = W3CValidators::VERSION

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency 'nokogiri', '~> 1.6'
  gem.add_dependency 'json', '>= 1.8'
  gem.add_dependency 'rexml', '~> 3.2'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'test-unit'
  gem.add_development_dependency 'webrick'
end
