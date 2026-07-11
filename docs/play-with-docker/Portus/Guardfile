guard :rspec, all_on_start: false, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)
  watch("spec/rails_helper.rb") { rspec.spec_dir }
  watch(%r{^spec/.+_spec\.rb$})

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("acceptance/#{m[1]}")
    ]
  end

  watch(rails.spec_helper) { rspec.spec_dir }
  watch(rails.routes) { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller) { "#{rspec.spec_dir}/controllers" }
end

guard :rubocop, all_on_start: true do
  watch(/.+\.rb\z/)
  watch(/\Abin\/.+\z/)

  watch(%r{(?:.+/)?\.rubocop\.yml$}) do |m|
    File.dirname(m[0])
  end
end
