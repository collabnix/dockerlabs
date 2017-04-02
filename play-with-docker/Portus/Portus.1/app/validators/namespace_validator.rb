# Validates the name of the namespace as specified by Docker Distribution.
class NamespaceValidator < ActiveModel::EachValidator
  NAME_REGEXP = /\A[a-z0-9]+(?:[._\\-][a-z0-9]+)*\Z/

  # Validator for the name.
  def validate_each(record, attribute, value)
    # Already validated by the presence validator.
    return if value.nil?
    return if value =~ NAME_REGEXP

    record.errors[attribute] << "can only contain lower case alphanumeric "\
      "characters, with optional underscores and dashes in the middle."
  end
end
