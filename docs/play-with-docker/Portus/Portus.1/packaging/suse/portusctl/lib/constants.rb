# Some useful constants used by portus

# Checks whether it's running inside of a Docker container or not
def dockerized?
  File.read("/proc/1/cgroup").include?("docker")
end

# This one is set by the bash wrapper we deliver with our RPM
# See packaging/suse/bin/portusctl
BUNDLER_BIN = ENV["BUNDLER_BIN"]
HOSTNAME    = (dockerized? || ENV["TRAVIS"] ? `hostname -f` : `hostnamectl --static status`).chomp
PORTUS_ROOT = "/srv/Portus".freeze
