require "docker"
require "pty"
require "spec_helper"

# The supported Docker Distribution versions. Make sure that these values
# correspond to valid tags on DockerHub.
# See: https://hub.docker.com/r/library/registry/tags/
SUPPORTED_DISTRIBUTION_VERSIONS = ["2.3.1", "2.4.0", "latest"].freeze

# Integration encapsulates an integration test. This method accepts one special
# tag: `distribution`. It can either be an Array of strings or a String, and it
# filters which versions of Docker distribution are to be tested. Useful when
# performing quick tests.
def integration(name, tags = {}, &blk)
  tags[:integration] = true unless tags.key?(:integration)

  # Returns early if test has been explicitly marked as `skip`.
  return if tags.key?(:skip) && tags[:skip]
  return if ENV["TRAVIS"]

  WebMock.allow_net_connect!
  VCR.turn_off!

  # Run the tests for the specified Distribution versions.
  versions, rebuild = parameters_from_tags(tags)
  versions.each { |version| setup_describe(name, version, rebuild, tags, &blk) }

  VCR.turn_on!
  WebMock.disable_net_connect!
end

# Setup the describe block for the given parameters.
def setup_describe(name, version, rebuild, tags, &blk)
  describe "#{name} (distribution: #{version}) (LDAP: #{ldap?})", tags do
    before :all do
      WebMock.allow_net_connect!
      VCR.turn_off!

      # Set everything up.
      once "setup" do
        cleanup!
        setup_db!
        ldap? ? setup_ldap!("johnldap", "12341234") : setup_portus!(rebuild)
        setup_templates!
      end

      cleanup_distribution!
      ensure_distribution!(version)

      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    before :each do
      WebMock.allow_net_connect!
      VCR.turn_off!

      reset_db!
      `docker restart integration_portus`
    end

    after :each do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    instance_eval(&blk)
  end
end

# Fetch some needed parameters from the given tags. It returns a two-sized
# array where the first item is an array of the docker distribution versions,
# and the last element is a boolean containing whether the Portus image has to
# be rebuilt or not.
def parameters_from_tags(tags)
  # Pick the versions to be executed.
  versions = SUPPORTED_DISTRIBUTION_VERSIONS
  if tags.key?(:distribution)
    filter = if tags[:distribution].is_a? Array
      tags[:distribution]
    else
      [tags[:distribution]]
    end
    versions &= filter
  end

  # Check if the Portus image has to be rebuilt.
  rebuild = true
  rebuild = tags[:rebuild] == true if tags.key?(:rebuild)

  [versions, rebuild]
end

# Execute the given block just once.
def once(id)
  yield if ENV["INTEGRATION_ONCE_BLOCK_#{id}"] != "t"
  ENV["INTEGRATION_ONCE_BLOCK_#{id}"] = "t"
end

# Returns whether LDAP has to be run on the current `integration` block.
def ldap?
  ENV["INTEGRATION_LDAP"] == "t" || ENV["INTEGRATION_LDAP"] == "true"
end

# Makes sure that there is a container running the given Docker distribution
# version.
def ensure_distribution!(version)
  name = "portus_distribution_#{version.delete(".")}"

  src  = File.expand_path(File.dirname(__FILE__)) + "/" + "fixtures"
  img  = "registry:#{version}"
  opts = {
    "Volumes"      => { src => { "/etc/docker/registry" => "ro,Z", "/registry_data" => "" } },
    "ExposedPorts" => { "5000/tcp" => {} },
    "HostConfig"   => {
      "Binds"        => ["#{src}:/etc/docker/registry", "#{src}/data:/registry_data"],
      "Links"        => ["integration_portus"],
      "PortBindings" => { "5000/tcp" => [{ "HostIP" => "0.0.0.0", "HostPort" => "5000" }] }
    }
  }

  start_container!(img, name, opts)
end

def reset_db!
  mysql_ping!

  # Migrate & seed
  docker_exec("integration_portus", "rake db:drop")
  docker_exec("integration_portus", "rake db:create")
  docker_exec("integration_portus", "rake db:migrate:reset")
  docker_exec("integration_portus", "rake db:seed")

  # Introduce the current registry.
  cmd = "Registry.create(name: 'registry', hostname: '#{registry_hostname}', use_ssl: false)"
  docker_exec("integration_portus", "rails runner \"#{cmd}\"")
end

# Returns the hostname of the current registry.
def registry_hostname
  "#{ip}:5000"
end

# Start a container from the given image. It accepts a hash with extended
# options that you might want to pass it on creation time.
def start_container!(image, name, ext = {})
  # Remove old containers.
  container = container_for(name)
  container.delete(force: true) if container

  opts = { "Image" => image }.merge(ext)

  begin
    container = Docker::Container.create(opts)
  rescue Docker::Error::NotFoundError
    puts "Pulling from #{image}"
    pull(image)
    container = Docker::Container.create(opts)
  end

  container.rename(name)
  puts "Starting container #{name}"
  container.start

  # Make sure that the container has actually started. Yes, the previous
  # `start` method does not say anything about this (and even worse, we don't
  # have a way in the client to tell why the container could not start).
  begin
    container.top
  rescue Docker::Error::ServerError
    raise StartError, "Could not start container '#{name}' from image '#{image}'."
  end
end

# Pulls a Docker image.
def pull(img)
  Docker::Image.create("fromImage" => img)
end

# Pushes an image onto the registry. An extra parameter can be passed telling
# this method whether a failure is expected or not. Returns a boolean telling
# whether the expection was met or not.
def push(img, succeed = true)
  `docker restart integration_portus`
  eventually_expect(succeed) { spawn_cmd("docker push #{img}") }
end

# Returns a container object for the given identifier. If the container does
# not exist, it returns nil.
def container_for(name)
  container = Docker::Container.get(name)

  # Check that the container is alive. It will raise a
  # Docker::Error::ServerError if that's not the case.
  container.top
  container
rescue Docker::Error::ServerError
  container.delete(force: true)
  nil
rescue Docker::Error::NotFoundError
  nil
end

# Ping the mysql container within the portus container. It will raise an error
# if a ping attempt fails 5 times.
def mysql_ping!
  conn = "--count=1 --connect-timeout=1"
  cred = "--host=integration_db -u root --password=portus"

  success = docker_exec("integration_portus", "mysqladmin #{conn} #{cred} ping", 5)
  raise StandardError, "Could not ping mysql database!" unless success
end

# Setup the database container.
def setup_db!
  start_container!(
    "library/mariadb:10.0.23",
    "integration_db",
    "Env" => ["MYSQL_ROOT_PASSWORD=portus"]
  )
end

# Setup the Portus container.
#   - rebuild: whether the image has to be rebuilt or not.
#   - env: a list of additional environment variables to be passed.
#   - ip: the IP that the Portus container should have.
def setup_portus!(rebuild = true, env = [], address = nil)
  dir = File.expand_path(File.dirname(__FILE__) + "../../../")

  # Build Portus with the current code and run it in a container.
  Dir.chdir(dir) do
    if rebuild
      # Docker::Image.build_from_dir fails spectacularly on this. Just execute
      # the damn command.
      puts "Building Portus from directory: #{dir}"
      PTY.spawn("docker build -t integration_portus:latest .") do |stdout, _, _|
        # rubocop:disable Lint/HandleExceptions
        begin
          stdout.each { |line| print line }
        rescue Errno::EIO
          # End of output
        end
        # rubocop:enable Lint/HandleExceptions
      end
    end

    opts = {
      "Env"          => [
        "PORTUS_MACHINE_FQDN_VALUE=#{ip}",
        "PORTUS_DB_HOST=integration_db",
        "RAILS_ENV=test",
        env
      ].flatten,
      "Volumes"      => { Dir.pwd => { "/portus" => "" } },
      "Cmd"          => "puma -b tcp://0.0.0.0:3000 -w 10".split(" "),
      "ExposedPorts" => { "3000/tcp" => {} },
      "HostConfig"   => {
        "Binds"        => ["#{Dir.pwd}:/portus"],
        "Links"        => ["integration_db"],
        "PortBindings" => { "3000/tcp" => [{ "HostIP" => "0.0.0.0", "HostPort" => "3000" }] }
      }
    }
    opts["NetworkSettings"] = { "IPAddress" => address } unless address.nil?
    start_container!("integration_portus:latest", "integration_portus", opts)
  end
end

def setup_templates!
  # Render the template
  @ip = ip
  src = File.expand_path(File.dirname(__FILE__)) + "/" + "fixtures"
  tpl = File.read(File.join(src, "config.yml.erb"))
  res = ERB.new(tpl, nil, "<>").result(binding)

  # Write it
  output = File.join(src, "config.yml")
  File.open(output, "w") { |file| file.write(res) }
end

# Get the IP from docker0
def ip
  docker0 = `/sbin/ifconfig docker0`
  ips     = docker0.scan(/(([0-9]{1,3}[\.]){3}[0-9]{1,3})/)
  ips.first.first
end

# Execute a command on the given container. Returns a boolean specifying
# whether the command succeeded or not.
def docker_exec(container, cmd, repeat = 0)
  success = spawn_cmd("docker exec -it #{container} #{cmd}")

  # Execute the failing command if we are allowed to do it.
  if !success && repeat != 0
    puts "Command '#{cmd}' failed! Waiting 5 seconds..."
    sleep 5
    docker_exec(container, cmd, repeat - 1)
  else
    success
  end
end

# Spawn a new command and return its exit status. It will print to stdout on
# real time.
def spawn_cmd(cmd)
  success = true

  PTY.spawn(cmd) do |stdout, _, pid|
    # rubocop:disable Lint/HandleExceptions
    begin
      stdout.each { |line| print line }
    rescue Errno::EIO
      # End of output
    end
    # rubocop:enable Lint/HandleExceptions

    Process.wait(pid)
    success = $CHILD_STATUS.exitstatus == 0
  end
  success
end

# Sets up an LDAP instance. The LDAP instance can be tweaked with the given
# name and password, which will be used to create a read-only user. Note that
# it will restart the portus and the distribution containers, so it is a bit
# slow.
def setup_ldap!(name, password)
  # Spin up the LDAP server.
  opts = {
    "Env" => [
      "LDAP_READONLY_USER=true",
      "LDAP_READONLY_USER_USERNAME=#{name}",
      "LDAP_READONLY_USER_PASSWORD=#{password}"
    ]
  }
  cname = "integration_ldap"
  start_container!("osixia/openldap:1.1.2", cname, opts)

  # And re-start the Portus container with the new LDAP config.
  hostname  = `docker inspect -f {{.NetworkSettings.IPAddress}} #{cname}`.strip
  portus    = `docker inspect -f {{.NetworkSettings.IPAddress}} integration_portus`.strip
  setup_portus!(false, [
                  "PORTUS_LDAP_ENABLED=true",
                  "PORTUS_LDAP_HOSTNAME=#{hostname}",
                  "PORTUS_LDAP_UID=cn",
                  "PORTUS_LDAP_BASE=dc=example,dc=org",
                  "PORTUS_LDAP_AUTHENTICATION_ENABLED=true",
                  "PORTUS_LDAP_AUTHENTICATION_BIND_DN=cn=admin,dc=example,dc=org",
                  "PORTUS_LDAP_AUTHENTICATION_PASSWORD=admin"
                ], portus)
end

# Execute the given command inside of the Portus container. Raises an ExecError
# on failure.
def portus_exec(cmd)
  raise ExecError, "Failed to execute '#{cmd}'" unless docker_exec("integration_portus", cmd)
end

# Create a new user.
# TODO: let it work in LDAP.
def create_user(name, email, password, admin = false)
  return if ldap?
  portus_exec("rake portus:create_user[#{name},#{email},#{password},#{admin}]")
end

# Error raised when a container fails to start.
class StartError < StandardError; end

# Error raised when a command fails inside of a Docker container.
class ExecError < StandardError; end

# Error raised when the login attempt has not been successful.
class LoginError < StandardError; end

# Error raised when an expectation is not met (e.g. `eventually_expect`).
class ExpectError < StandardError; end

# Log in the given user. It raises a LoginError on failure.
def login(user, password, email)
  eventually_expect true do
    output = `docker login -u #{user} -e #{email} -p #{password} #{registry_hostname}`
    output.include? "Login Succeeded"
  end

rescue ExpectError
  raise LoginError, "Login failed!"
end

# Logout.
def logout!
  `docker logout #{registry_hostname}`
end

# Execute a command to the Rails CLI, while expecting a JSON response. Returns
# the JSON object already parsed.
def rails_exec(cmd)
  cmd = "puts #{cmd}"
  output = capture_stdout do
    docker_exec("integration_portus", "rails runner \"#{cmd}\"")
  end

  res = output.split("\n").last.strip
  JSON.load(res)
end

# Capture the stdout of the given block.
def capture_stdout
  stream = StringIO.new
  orginal = $stdout
  $stdout = stream
  yield
  stream.string
ensure
  $stdout = orginal
end

# Run the given block and check whether it meets the given expectation for a
# reasonable amount of time. If not, it will raise an `ExpectError` exception.
def eventually_expect(expect)
  15.times do
    res = yield
    return true if res == expect
    puts "Expecting '#{expect}', got '#{res}'"
    sleep 5
  end
  raise ExpectError, "Eventual expectation failed"
end

# Cleanup all the containers that might be running.
def cleanup!
  ["integration_db", "integration_portus", "integration_ldap"].each do |container|
    cleanup_container!(container)
  end
  cleanup_distribution!
end

# Cleanup distribution versions.
def cleanup_distribution!
  SUPPORTED_DISTRIBUTION_VERSIONS.map { |v| "portus_distribution_#{v.delete(".")}" }.each do |c|
    cleanup_container!(c)
  end
end

# Forces the removal of the given container.
def cleanup_container!(container)
  # rubocop:disable Lint/HandleExceptions
  Docker::Container.get(container)
  system("docker rm -f #{container}")
rescue Docker::Error::NotFoundError
  # Container does not exist, moving on.
  # rubocop:enable Lint/HandleExceptions
end
