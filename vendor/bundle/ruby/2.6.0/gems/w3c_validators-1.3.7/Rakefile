require 'rubygems'
require 'bundler/setup'

$: << File.expand_path(File.dirname(__FILE__))
$: << File.expand_path(File.dirname(__FILE__)) + '/test'

require 'rake'
require 'rdoc/task'
require 'rake/testtask'
require 'lib/w3c_validators'
require 'fileutils'

include W3CValidators

desc 'Run the unit tests.'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'lib/test'
  t.test_files = FileList['test/test*.rb'].exclude('test_helper.rb')
  t.verbose = true
end

desc 'Generate documentation for W3C Validators.'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Ruby W3C Validators'
  rdoc.options << '--all' << '--inline-source' << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('LICENSE')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('lib/*.rb')
  rdoc.rdoc_files.include('lib/w3c_validators/*.rb')
end

desc 'Create the gem spec'
task :create_gemspec do
  File.open("w3c_validators.gemspec","w") do |file|
    file.puts <<-EOH
# Auto-generated gemspec
# Run 'rake generate_gemspec' to re-generate
Gem::Specification.new do |s|
  s.name     = "w3c_validators"
  s.platform = Gem::Platform::RUBY
  s.version  = "1.1.1"
  s.date     = "2010-10-20"
  s.summary  = "Wrapper for the World Wide Web Consortium's online validation services."
  s.email    = "code@dunae.ca"
  s.homepage = "http://code.dunae.ca/w3c_validators"
  s.description = "W3C Validators is a Ruby wrapper for the World Wide Web Consortium's online validation services."
  s.has_rdoc = true
  s.author  = "Alex Dunae"
  s.add_dependency('nokogiri', 'json')
  s.extra_rdoc_files = ['README.rdoc', 'CHANGELOG', 'LICENSE']
  s.rdoc_options << '--all' << '--inline-source' << '--line-numbers' << '--charset' << 'utf-8'
EOH
  
    file.puts "  s.test_files = ['" +  Dir.glob('test/test_*.rb').join("','") + "']"
    file.puts "  s.files = ['" +  FileList["{lib}/**/*"].join("','") + "']"
    file.puts 'end'
  end
end

task :default => :test

