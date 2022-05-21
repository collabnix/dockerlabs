# Allows the creation of exactly one registry. It also allows updating the
# "use_ssl" attribute of a given registry. Doing all this is safe because only
# admin users will be able to reach this controller.
class Admin::RegistriesController < Admin::BaseController
  before_action :registry_created, only: [:new, :create]

  # GET /admin/registries/
  def index
    @registries = Registry.all
  end

  # GET /admin/registries/new
  def new
    @registry = Registry.new
  end

  # POST /admin/registries
  #
  # This method checks whether the given registry is reachable or not. If it
  # is not, then it will redirect back to the :new page asking for
  # confirmation. If the :force parameter is passed, then this check is not
  # done. If this check is passed/skipped, then it will try to create the
  # registry.
  def create
    @registry = Registry.new(create_params)

    # Check the reachability of the registry.
    unless params[:force]
      msg = @registry.reachable?
      unless msg.empty?
        logger.info "\nRegistry not reachable:\n#{@registry.inspect}\n#{msg}\n"
        msg = "#{msg} You can skip this check by clicking on the \"Skip remote checks\" checkbox."
        hsh = { name: @registry.name, hostname: @registry.hostname,
          use_ssl: @registry.use_ssl, external_hostname: @registry.external_hostname }
        redirect_to new_admin_registry_path(hsh), alert: msg
        return
      end
    end

    if @registry.save
      Namespace.update_all(registry_id: @registry.id)
      redirect_to admin_registries_path, notice: "Registry was successfully created."
    else
      redirect_to new_admin_registry_path, alert: @registry.errors.full_messages
    end
  end

  # GET /admin/registries/:id/edit
  #
  # Note that the admin will only be able to edit the hostname if there are no
  # repositories.
  def edit
    @registry            = Registry.find(params[:id])
    @can_change_hostname = !Repository.any?
  end

  # PUT /admin/registries/1
  #
  # Right now this just toggles the value of the "use_ssl" attribute for the
  # given registry. This might change in the future.
  def update
    @registry = Registry.find(params[:id])
    @registry.update_attributes(update_params)
    redirect_to admin_registries_path, notice: "Registry updated successfully!"
  end

  private

  # Raises a routing error if there is already a registry in place.
  # NOTE: (mssola) remove this once we support multiple registries.
  def registry_created
    raise ActionController::RoutingError, "Not found" if Registry.count > 0
  end

  # The required/permitted parameters on the create method.
  def create_params
    params.require(:registry).permit(:name, :hostname, :use_ssl, :external_hostname)
  end

  # The required/permitted parameters on update. The hostname parameter will be
  # allowed depending whether there are repositories already created or not.
  def update_params
    permitted = [:name, :use_ssl, (:hostname unless Repository.any?), :external_hostname].compact
    params.require(:registry).permit(permitted)
  end
end
