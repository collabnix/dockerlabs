module Portus
  # This is the base class for AuthScope classes. An AuthScope class retrieves
  # the information that can be extracted from a Docker scope string for the
  # represented resource.
  #
  # An AuthScope class is required at least provide an implementation for the
  # `resource` method.
  class AuthScope
    # The given resource was not found.
    class ResourceNotFound < StandardError; end

    attr_accessor :resource, :actions, :resource_type, :resource_name

    def initialize(registry, scope_string)
      @scope_string = scope_string
      @registry     = registry
      parse_scope_string!
    end

    # Returns the resource matching the requirements of an initialized
    # AuthScope. It raises the Portus::AuthScope::ResourceNotFound exception if
    # the required resource could not be found.
    def resource
      # Implemented by subclasses.
    end

    # Returns an array containing the scopes available for this scope. The
    # items on this array must match the names of a boolean method inside this
    # resource's policy. For example, if we have a subclass Klass::AuthScope
    # and this method returns ["pull", "push"], then the corresponding policy
    # class KlassPolicy must define the boolean methods "pull?" and "push?".
    #
    # By default this method will return all the actions defined in the last
    # element of the scope string.
    #
    # On error, this method should return an empty array.
    def scopes
      @actions
    end

    protected

    # Parses the @scope_string variable into the needed attributes.
    def parse_scope_string!
      parts = @scope_string.split(":", 3)
      @resource_type = parts[0]
      @resource_name = parts[1]
      @actions       = parts[2]
      @actions       = @actions.split(",") if @actions
    end
  end
end
