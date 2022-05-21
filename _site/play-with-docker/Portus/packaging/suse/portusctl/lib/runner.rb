# Helper file used to run external commands
class Runner
  # Run a simple external command. Keep in mind that this method will raise an
  # exception if the command fails.
  def self.exec(cmd, args = [])
    final_cmd = Runner.escape_command(cmd, args)
    unless system(final_cmd)
      raise "Something went wrong while invoking: #{final_cmd}"
    end
  end

  # Run a simple external command. This is equivalent to `Runner.exec`, but this
  # method does not raise any exception. Instead, it returns a true on success
  # and false otherwise.
  def self.safe_exec(cmd, args = [])
    final_cmd = Runner.escape_command(cmd, args)
    system(final_cmd)
  end

  # Returns a string containing the command with its arguments all escaped.
  def self.escape_command(cmd, args = [])
    cmd + " " + args.map { |a| Shellwords.escape(a) }.join(" ")
  end

  # Run an external command using the bundler binary shipped with Portus' RPM
  def self.bundler_exec(cmd, args, extra_env_variables)
    Dir.chdir(PORTUS_ROOT) do
      extra_env_variables.each do |key, value|
        ENV[key] = value
      end
      exec(BUNDLER_BIN, ["exec", cmd, *args])
    end
  end

  # Ensure a service is enabled and is running
  # Takes care of restarting the service when requested
  # by the user via the `restart` boolean parameter.
  def self.activate_service(service, restart = false)
    Runner.exec("systemctl", ["enable", service])
    Runner.exec(
      "systemctl",
      [
        restart ? "restart" : "start",
        service
      ]
    )
  end

  # Creates a new file called "versions.log" with information about the version
  # of the different components.
  def self.produce_versions_file!
    File.open(File.join(PORTUS_ROOT, "log/versions.log"), "w+") do |file|
      %w(docker docker-distribution-registry Portus).each do |package|
        rpm = `rpm -qi #{package}`
        file.puts("#{rpm}\n")
      end
    end
  end

  # Creates a new file called "crono.log" with the logs stored by systemd about
  # crono.
  def self.produce_crono_log_file!
    File.open(File.join(PORTUS_ROOT, "log/crono.log"), "w+") do |file|
      cmd = Runner.escape_command("journalctl", ["--no-pager", "-u", "portus_crono"])
      file.puts(`#{cmd}`)
    end
  end

  # Tar and compress the given files into the /tmp directory. It's assumed that
  # these files are located inside of PORTUS_ROOT.
  def self.tar_files(*files)
    Dir.chdir(PORTUS_ROOT) do
      FileUtils.touch files
      Runner.exec("tar", ["czf", "portus_logs.tar.gz", *files])
      FileUtils.mv "portus_logs.tar.gz", "/tmp"
    end

    puts "You can find your logs here: /tmp/portus_logs.tar.gz"
  end
end
