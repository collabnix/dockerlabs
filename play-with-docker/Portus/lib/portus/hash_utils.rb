module Portus
  # The HashUtils modules include some helper methods that can be useful for
  # some hashes (e.g. the ones that deal with configuration management).
  module HashUtils
    # Applies a deep merge while respecting the values from environment
    # variables. A deep merge consists of a merge of all the nested elements of
    # the two given hashes `cfg` and `local`. The `cfg` hash is supposed to
    # contain all the accepted keys, and the `local` hash is a subset of it.
    #
    # Moreover, let's say that we have the following hash:
    # { "ldap" => { "enabled" => true } }. An environment variable that can
    # modify the value of the previous hash has to be named
    # `PORTUS_LDAP_ENABLED`. The `prefix` argument specifies how all the
    # environment variables have to start. It defaults to "PORTUS".
    #
    # Returns the merged hash, where the precedence of the merge is as follows:
    #   1. The value of the related environment variable if set.
    #   2. The value from the `local` hash.
    #   3. The value from the `cfg` hash.
    def strict_merge_with_env(cfg, local, prefix = "portus")
      hsh = {}

      cfg.each do |k, v|
        # The corresponding environment variable. If it's not the final value,
        # then this just contains the partial prefix of the env. variable.
        env = "#{prefix}_#{k}"

        # If the current value is a hash, then go deeper to perform a deep
        # merge, otherwise we merge the final value by respecting the order as
        # specified in the documentation.
        if v.is_a?(Hash)
          l = local[k] || {}
          hsh[k] = strict_merge_with_env(cfg[k], l, env)
        else
          hsh[k] = first_non_nil(get_env(env), local[k], v)
        end
      end
      hsh
    end

    # Hide any sensitive value, replacing it with "*" characters.
    def hide_password(hsh)
      hsh.each do |k, v|
        if v.is_a?(Hash)
          hsh[k] = hide_password(v)
        elsif k == "password"
          hsh[k] = "****"
        end
      end
      hsh
    end

    private

    # Get the typed value of the specified environment variable. If it doesn't
    # exist, it will return nil. Otherwise, it will try to cast the fetched
    # value into the proper type and return it.
    def get_env(key)
      env = ENV[key.upcase]
      return nil if env.nil?

      # Try to convert it into a boolean value.
      return true if env.casecmp("true").zero?
      return false if env.casecmp("false").zero?

      # Try to convert it into an integer. Otherwise just keep the string.
      begin
        Integer(env)
      rescue ArgumentError
        env
      end
    end

    # Returns the first value that is not nil from the given argument list.
    def first_non_nil(*values)
      values.each { |v| return v unless v.nil? }
    end
  end
end
