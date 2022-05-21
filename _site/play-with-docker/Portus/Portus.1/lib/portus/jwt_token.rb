require "portus/migrate"

module Portus
  # This class implements the JSON Web Token as expected by the registry. Read
  # the `spec` for more information:
  #
  #   https://github.com/docker/distribution/blob/master/docs/spec/auth/token.md
  #
  class JwtToken
    # The constructor takes the query parameters as specified in the
    # specification. The given scopes are assumed to have already been processed
    # by the caller with the authorized scopes.
    def initialize(account, service, scopes)
      @account = account
      @service = service
      @scopes = scopes
    end

    # Returns a hash containing the encoded token, ready to be sent as a JSON
    # response.
    def encoded_hash
      headers = { "kid" => JwtToken.kid(private_key) }
      {
        token:      JWT.encode(claim.deep_stringify_keys, private_key, "RS256", headers),
        expires_in: expiration_time,
        issued_at:  Time.zone.at(issued_at).to_datetime.rfc3339
      }.freeze
    end

    # Returns a hash containing the "Claim" set as described in the
    # specification.
    def claim
      @claim ||= {}.tap do |hash|
        hash[:iss]    = APP_CONFIG["machine_fqdn"]["value"]
        hash[:sub]    = @account
        hash[:aud]    = @service
        hash[:iat]    = issued_at
        hash[:nbf]    = issued_at - 5.seconds
        hash[:exp]    = issued_at + expiration_time
        hash[:jti]    = jwt_id
        hash[:access] = authorized_access if @scopes
      end
    end

    # Returns the private key to be used.
    def private_key
      @private_key ||= begin
        key_path = Rails.application.secrets.encryption_private_key_path
        binkey = File.binread(Rails.root.join(key_path))
        OpenSSL::PKey::RSA.new(binkey)
      end
    end

    # Generates and returns a "kid" value to be used in the JOSE header. Read
    # the specification for further information.
    def self.kid(private_key)
      sha256 = Digest::SHA256.new
      sha256.update(private_key.public_key.to_der)
      payload = StringIO.new(sha256.digest).read(30)
      Base32.encode(payload).split("").each_slice(4).each_with_object([]) do |slice, mem|
        mem << slice.join
      end.join(":")
    end

    protected

    # The expiration time to be added to the current token.
    def expiration_time
      value = Portus::Migrate.registry_config("jwt_expiration_time")
      Portus::Migrate.from_humanized_time(value, 5)
    end

    # Returns an array with the authorized actions hash.
    def authorized_access
      @scopes.map do |scope|
        {
          type:    scope.resource_type,
          name:    scope.resource_name,
          actions: scope.actions
        }
      end
    end

    # Returns a (hopefully) unique id for the JWT token.
    def jwt_id
      SecureRandom.base58(42)
    end

    # Returns the time in which the token has been issued (now).
    def issued_at
      @now ||= Time.zone.now.to_i
    end
  end
end
