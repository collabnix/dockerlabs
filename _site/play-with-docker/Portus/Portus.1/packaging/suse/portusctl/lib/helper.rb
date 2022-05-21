def check_setup_flags(options)
  if options["ssl-gen-self-signed-certs"] && \
      !options["ssl-certs-dir"].chomp.empty?
    warn "cannot use both options --ssl-gen-self-signed-certs and " \
      "--ssl-certs-dir at the same time"
    exit 1
  end

  return unless options["ldap-enable"] && \
      (options["ldap-hostname"].nil? || options["ldap-hostname"].empty?)

  warn "LDAP support is enabled but you didn't specify a value for ldap-hostname"
  exit 1
end

def ensure_root
  return if Process.uid == 0

  warn "Must run as root user"
  exit 1
end

def handle_own_certs(path)
  puts "Using keys from #{path}"
  key_file = File.join(path, "#{HOSTNAME}-ca.key")
  crt_file = File.join(path, "#{HOSTNAME}-ca.crt")

  missing_file(key_file, path) unless File.exist?(key_file)
  FileUtils.cp(key_file, "/etc/apache2/ssl.key")

  missing_file(crt_file, path) unless File.exist?(crt_file)
  FileUtils.cp(crt_file, "/etc/apache2/ssl.crt")
end

def missing_file(filename, path = "")
  if path.empty?
    warn "missing file #{filename}.\n" \
      "Use --ssl-gen-self-signed-certs to generate new certificates, or " \
      "--ssl-certs-dir <path> to specify a directory containing certificates."
  else
    warn "cannot find file #{File.basename filename} inside of #{path}."
  end
  exit 1
end
