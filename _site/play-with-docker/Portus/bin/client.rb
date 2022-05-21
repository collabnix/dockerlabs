# This script has to be used inside of the `rails runner` command. So, for
# example, to get the results from the manifest:
#
#   $ rails runner manifest mssola/busybox:latest
#
# These are the available commands:
#   - catalog
#   - delete <name> <digest> blobs/manifests
#   - manifest <name>[:<tag>]
#   - ping <hostname:port> [use_ssl]

require "pp"

# Returns a boolean depending on what the user instructed to the ping
# command. If the arguments are not what we expect, then it prints an error
# message and exits the program.
def use_ssl?
  use = false

  if ARGV.size == 2
    puts "Beware: use_ssl omitted, assuming false."
  elsif ARGV.size == 3
    use = ARGV.last == "use_ssl"
    puts "Beware: use \"use_ssl\", assuming false." unless use
  else
    puts "Usage: rails runner ping hostname:port [use_ssl]"
    exit 1
  end

  use
end

registry = Registry.get
if registry.nil? && ARGV.first != "ping"
  puts "No registry has been configured!"
  exit 1
end

case ARGV.first
when "catalog"
  catalog = registry.client.catalog
  puts catalog.inspect
  puts "Size: #{catalog.size}"
when "delete"
  if ARGV.length != 4
    puts "usage: delete <name> <digest> blobs/manifests"
    exit 1
  end

  if ARGV[3] != "blobs" && ARGV[3] != "manifests"
    puts "Unknown #{ARGV[3]} object. Only available: blobs and manifests."
    exit 1
  end

  pp registry.client.delete(ARGV[1], ARGV[2], ARGV[3])
when "manifest"
  if ARGV.length == 1
    puts "You have to at least specify the name of the image"
    exit 1
  end

  if ARGV[1].include?(":")
    name, tag = ARGV[1].split(":")
  else
    name = ARGV[1]
    tag = "latest"
  end

  id, digest, manifest = registry.client.manifest(name, tag)
  puts "Image ID: #{id} (truncated as in Docker: #{id[0, 12]})"
  puts "Manifest digest: #{digest}"
  puts JSON.pretty_generate(manifest)
when "ping"
  # No registry was found, trying to ping another one.
  registry = Registry.new(hostname: ARGV[1], use_ssl: use_ssl?) if registry.nil?

  if registry.client.reachable?
    puts "Registry reachable"
  else
    puts "Error: cannot reach the registry"
  end
else
  puts "Valid commands: catalog, delete, manifest and ping."
  exit 1
end
