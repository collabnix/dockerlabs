# TokensController is used to deliver the token that the docker client should
# use in order to perform operation into the registry. This is the last step in
# the authentication process for Portus' point of view.
class Api::V2::TokensController < Api::BaseController
  before_action :attempt_authentication_against_application_tokens

  # Try to perform authentication using the application tokens. The password
  # provided via HTTP basic auth is going to be checked against the application
  # tokens a user might have created.
  # If the user has a valid application token then the other forms of
  # authentication (Portus' database, LDAP) are going to be skipped.
  def attempt_authentication_against_application_tokens
    user = authenticate_with_http_basic do |username, password|
      user = User.find_by(username: username)
      user if user && user.application_token_valid?(password)
    end
    sign_in(user, store: true) if user
  end

  # Returns the token that the docker client should use in order to perform
  # operation into the private registry.
  def show
    authenticate_user! if request.headers["Authorization"]
    registry = Registry.find_by_hostname(params[:service])

    auth_scopes = []
    auth_scopes = authorize_scopes(registry) unless registry.nil?

    token = Portus::JwtToken.new(params[:account], params[:service], auth_scopes)
    logger.tagged("jwt_token", "claim") { logger.debug token.claim }
    render json: token.encoded_hash
  end

  private

  # If there was a scope specified in the request parameters, try to authorize
  # the given scopes. That is, it "filters" the scopes that can be requested
  # depending of the issuer of the request and its permissions.
  #
  # If no scope was specified, this is a login request and it just returns nil.
  def authorize_scopes(registry)
    scopes =  Array(Rack::Utils.parse_query(request.query_string)["scope"])
    return if scopes.empty?

    auth_scopes = {}

    # First try to fetch the requested scopes and the handler. If no scopes
    # were successfully given, respond with a 401.
    scopes.each do |scope|
      auth_scope, actions = scope_handler(registry, scope)

      actions.each do |action|
        # It will try to check if the current user is authorized to access the
        # scope given in this iteration. If everything is fine, then nothing will
        # happen, otherwise there are two possible exceptions that can be raised:
        #
        #   - NoMethodError: the targeted resource does not handle the scope that
        #     is being checked. It will raise a ScopeNotHandled.
        #   - Pundit::NotAuthorizedError: the targeted resource unauthorized the
        #     given user for the scope that is being checked. In this case this
        #     scope gets removed from `auth_scope.actions`.
        begin
          authorize auth_scope.resource, "#{action}?".to_sym
        rescue NoMethodError, Pundit::NotAuthorizedError, Portus::AuthScope::ResourceNotFound
          logger.debug "action #{action} not handled/authorized, removing from actions"
          auth_scope.actions.delete_if { |a| match_action(action, a) }
        end
      end

      next if auth_scope.actions.empty?
      # if there is already a similar scope (type and resource name),
      # we combine them into one:
      # e.g. scope=repository:busybox:push&scope=repository:busybox:pull
      #      -> access=>[{:type=>"repository", :name=>"busybox", :actions=>["push", "pull"]}
      k = [auth_scope.resource_type, auth_scope.resource_name]
      if auth_scopes[k]
        auth_scopes[k].actions.concat(auth_scope.actions).uniq!
      else
        auth_scopes[k] = auth_scope
      end
    end
    auth_scopes.values
  end

  # Returns true if the given item matches the given action.
  def match_action(action, item)
    action = "*" if action == "all"
    action == item
  end

  # From the given scope string, try to fetch a scope handler class for it.
  # Scope handlers are defined in "app/models/*/auth_scope.rb" files.
  def scope_handler(registry, scope_string)
    str = scope_string.split(":", 3)
    raise ScopeNotHandled, "Wrong format for scope string" if str.length != 3

    case str[0]
    when "repository"
      auth_scope = Namespace::AuthScope.new(registry, scope_string)
    when "registry"
      auth_scope = Registry::AuthScope.new(registry, scope_string)
    else
      raise ScopeNotHandled, "Scope not handled: #{str[0]}"
    end

    [auth_scope, auth_scope.scopes.dup]
  end
end
