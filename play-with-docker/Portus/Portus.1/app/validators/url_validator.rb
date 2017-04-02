require "uri"

# Validates URLs
class UrlValidator < ActiveModel::EachValidator
  # Validator for the url.
  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    return if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    record.errors[attribute] << "is not a valid URL"
  rescue URI::InvalidURIError
    record.errors[attribute] << "is not a valid URL"
  end
end
