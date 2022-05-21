module Portus
  # The Portus::Migrate module implements some methods that are used to handle a
  # change from different versions of Portus where there is an old (and
  # deprecated) way of doing things and a preferred new one.
  module Migrate
    # This method has to be used when migrating from an 'x.minutes' string
    # configuration value (e.g. the `jwt_expiration_time` value).
    #
    # The duration parameter is the given original value, and the default
    # parameter is an Integer with the value to be used whenever there is
    # an error. Otherwise, if the given duration is not an integer and has
    # a good (old) string format, then eval will be used just as we did
    # it before.
    #
    # TODO: (mssola) remove in the next version.
    def self.from_humanized_time(duration, default)
      return duration.send(:minutes) if duration.is_a? Integer

      # If it's not a String then just return the given default value.
      return default.send(:minutes) unless duration.is_a? String

      # If it's a string containing just a number, then convert it and return
      # it. Otherwise, if it has a bad (old) format, then just return the default.
      splitted = duration.split(".")
      if splitted.size == 1
        val = splitted.first.to_i
        return val.send(:minutes) unless val == 0
      end
      return default.send(:minutes) if splitted.size != 2

      Rails.logger.tagged("deprecated") do
        Rails.logger.warn "The 'x.minutes' format is deprecated for configuration values such " \
                          "as `jwt_expiration_time`. From now on these values are expected to " \
                          "be integers representing minutes."
      end

      # rubocop:disable Lint/Eval
      eval(duration)
      # rubocop:enable Lint/Eval
    end

    # Provides a compatibility layer for Portus 2.1 for users that haven't
    # migrated yet from `jwt_expiration_time` to `registry.jwt_expiration_time`.
    #
    # TODO: (mssola) remove in the next version.
    def self.registry_config(key)
      return APP_CONFIG["registry"][key]["value"] if APP_CONFIG["registry"]

      Rails.logger.tagged("deprecated") do
        Rails.logger.warn "The usage of '#{key}' is deprecated and it's now under the 'registry' "\
                          "configuration section."
      end

      APP_CONFIG[key]["value"]
    end
  end
end
