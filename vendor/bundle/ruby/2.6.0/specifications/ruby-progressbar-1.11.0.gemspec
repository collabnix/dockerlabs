# -*- encoding: utf-8 -*-
# stub: ruby-progressbar 1.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-progressbar".freeze
  s.version = "1.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/jfelchner/ruby-progressbar/issues", "changelog_uri" => "https://github.com/jfelchner/ruby-progressbar/blob/master/CHANGELOG.md", "documentation_uri" => "https://github.com/jfelchner/ruby-progressbar/tree/releases/v1.11.0", "homepage_uri" => "https://github.com/jfelchner/ruby-progressbar", "source_code_uri" => "https://github.com/jfelchner/ruby-progressbar", "wiki_uri" => "https://github.com/jfelchner/ruby-progressbar/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["thekompanee".freeze, "jfelchner".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIEGDCCAoCgAwIBAgIBAjANBgkqhkiG9w0BAQsFADAyMTAwLgYDVQQDDCdhY2Nv\ndW50c19ydWJ5Z2Vtcy9EQz10aGVrb21wYW5lZS9EQz1jb20wHhcNMjAxMjI2MjIz\nMTE2WhcNMjExMjI2MjIzMTE2WjAyMTAwLgYDVQQDDCdhY2NvdW50c19ydWJ5Z2Vt\ncy9EQz10aGVrb21wYW5lZS9EQz1jb20wggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAw\nggGKAoIBgQCqhYn5ODEoLvuBIF2M1GzoaZU28+ntP5QApvDE0Te04n0JbBC1cNYH\nmr71neeSx7tlZ9w9kJ/8GNcY5bm7pNJqhyhfc+uG9M7FttcxM8AYXogjcdUDP234\n+TdmZIz20JxtWBgAZK2I3ktlgLFLC3Pxq63yzhJ75Xok07Wh+ypwjGzDNofPhz+y\nXR+UeUTp2UGe7kDVoqu/AwwPVhk1qUIRFLfC8SLDTD0CuNW3/AnkwQrKSm8vkiIn\nq9GCnOq0+jQly0b6a1Gi3ZDYEEswnTzziw2gotUZnQkF5bcOcxK1CB/Okk2jtG7i\nztMEU785tERbOSszZrz9rBS/+GnMxlD0pxy50zFfHX3jY1hwnwGjE8Gg+0iYr/tm\neysjhcbZfKrMynoqAioCSwstIwtYYYYpYzCPZzwaIBaBqQmUTkuMeiGbAdOdFOrR\nlOgl5jxCYbNOOTaXbm0nGBFaTucB88+JLbsNAuoNGUf/ybDcZ1zKRkMr2vtb+OtL\nGoP81fN6l88CAwEAAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0O\nBBYEFC+HleDjPYe35DNu6n/aeK2oB4ugMA0GCSqGSIb3DQEBCwUAA4IBgQCbuxKj\nZyvFu5mUDEWCf1dT5mqFSyFznVCjQAQygDnz6JkCQlIG93IDtVLEmHrx7hm3dOYt\nHgPlsSgkoYIgsLYsR9ZIKjA2O5m3QUbo9uOtF4iRi0Obni8fVv7VZVebRfA7ypCo\nn625lDRIzc/zGVcI37bzIlDXC0aK3oaBVFmN1Uj5LNMW62hTDdMBx4HcUKI45R3g\nclUG96OBIyrYky3j6zpy6EpBaEdRWR68Yn4Tdba7xE9WzP3DCInjX3KPx+f0PPVK\nHzsXX6TlwXk2P9DwOTZRjz7vAmvTgZGWjlfq3dgQJBgjB+UKQVHxKEGUC/comr7c\nvPnXgn+nF38pK/hp/O9/lTpNplKrUvOB9+6nkwbxCPTQQO8In3pC6ixUzr/6wx9R\nURbz4/Czf5LMUmzqDni0GvBkXElaXzaIRoPM/T7b1LrRsZO3DwGFAasSrR27+ZgU\nSv+7zM1SqVOK2Vhp99UBBVIZTHSJWh4sCU7dJrUJTqvwwS3ayTiUlIi5TdQ=\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2020-12-31"
  s.description = "Ruby/ProgressBar is an extremely flexible text progress bar library for Ruby. The output can be customized with a flexible formatting system including: percentage, bars of various formats, elapsed time and estimated time remaining.".freeze
  s.email = ["support@thekompanee.com".freeze]
  s.homepage = "https://github.com/jfelchner/ruby-progressbar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Ruby/ProgressBar is a flexible text progress bar library for Ruby.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<rspectacular>.freeze, ["~> 0.70.6"])
      s.add_development_dependency(%q<fuubar>.freeze, ["~> 2.3"])
      s.add_development_dependency(%q<timecop>.freeze, ["= 0.6.0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<rspectacular>.freeze, ["~> 0.70.6"])
      s.add_dependency(%q<fuubar>.freeze, ["~> 2.3"])
      s.add_dependency(%q<timecop>.freeze, ["= 0.6.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<rspectacular>.freeze, ["~> 0.70.6"])
    s.add_dependency(%q<fuubar>.freeze, ["~> 2.3"])
    s.add_dependency(%q<timecop>.freeze, ["= 0.6.0"])
  end
end
