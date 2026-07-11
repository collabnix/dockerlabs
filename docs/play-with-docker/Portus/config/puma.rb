#!/usr/bin/env puma

# Workers and connections.
threads 1, ENV["PORTUS_PUMA_MAX_THREADS"] || 1
workers ENV["PORTUS_PUMA_WORKERS"] || 1

# We can bind in three different ways:
#
#  1. TCP and SSL. For this, you have to specify the host and the path to the
#     certificates. This is the preferred setup for production environments.
#  2. TCP with no SSL. For this, simply specify the host. Good for development
#     purposes inside of a container.
#  3. UNIX socket. This is the default and it's good for development purposes if
#     you are not using a container setup.
if ENV["PORTUS_PUMA_HOST"]
  if ENV["PORTUS_PUMA_TLS_KEY"]
    host, port = ENV["PORTUS_PUMA_HOST"].split(":")
    port ||= "3000"
    ssl_bind host, port,
             key:  ENV["PORTUS_PUMA_TLS_KEY"],
             cert: ENV["PORTUS_PUMA_TLS_CERT"]
  else
    bind "tcp://#{ENV["PORTUS_PUMA_HOST"]}"
  end
else
  bind "unix://#{File.join(Dir.pwd, "tmp/sockets/puma.sock")}"
end

# Daemon config. It will save the pid to tmp/pids/puma.pid. All the output
# from both stdout and stderr will be redirected to logs/puma.log.
#
# You should not set this when running in a Docker container.
if ENV["PORTUS_PUMA_DAEMONIZE"] == "yes"
  log_file = File.join(Dir.pwd, "log/puma.log")
  stdout_redirect log_file, log_file, true
  pidfile File.join(Dir.pwd, "tmp/pids/puma.pid")
  daemonize
end

# Copy on write.
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
