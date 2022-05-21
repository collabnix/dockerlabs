# rubocop:disable Naming/FileName
# frozen_string_literal: true

def require_all(path)
  dir = File.join(File.dirname(__FILE__), path)
  Dir[File.join(dir, '*.rb')].sort.each do |f|
    require f
  end
end

require_relative 'html-proofer/utils'
require_all 'html-proofer'
require_all 'html-proofer/check'

require 'parallel'
require 'fileutils'

begin
  require 'awesome_print'
  require 'pry-byebug'
rescue LoadError; end # rubocop:disable Lint/SuppressedException
module HTMLProofer
  def self.check_file(file, options = {})
    raise ArgumentError unless file.is_a?(String)
    raise ArgumentError, "#{file} does not exist" unless File.exist?(file)

    options[:type] = :file
    HTMLProofer::Runner.new(file, options)
  end

  def self.check_directory(directory, options = {})
    raise ArgumentError unless directory.is_a?(String)
    raise ArgumentError, "#{directory} does not exist" unless Dir.exist?(directory)

    options[:type] = :directory
    HTMLProofer::Runner.new([directory], options)
  end

  def self.check_directories(directories, options = {})
    raise ArgumentError unless directories.is_a?(Array)

    options[:type] = :directory
    directories.each do |directory|
      raise ArgumentError, "#{directory} does not exist" unless Dir.exist?(directory)
    end
    HTMLProofer::Runner.new(directories, options)
  end

  def self.check_links(links, options = {})
    raise ArgumentError unless links.is_a?(Array)

    options[:type] = :links
    HTMLProofer::Runner.new(links, options)
  end
end
# rubocop:enable Naming/FileName
