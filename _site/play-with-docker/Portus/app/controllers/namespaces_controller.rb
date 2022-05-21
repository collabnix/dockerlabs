class NamespacesController < ApplicationController
  include ChangeNameDescription

  respond_to :html, :js
  before_action :set_namespace, only: [:change_visibility, :show, :update]
  before_action :check_team, only: [:create]
  before_action :check_role, only: [:create]

  after_action :verify_authorized, except: [:index, :typeahead]
  after_action :verify_policy_scoped, only: :index

  # GET /namespaces
  # GET /namespaces.json
  def index
    @special_namespaces = Namespace.where(
      "global = ? OR namespaces.name = ?", true, current_user.username
    ).order("created_at ASC")
    @namespaces = policy_scope(Namespace).page(params[:page])
                                         .order("namespaces.created_at ASC")

    respond_with(@namespaces)
  end

  # GET /namespaces/1
  # GET /namespaces/1.json
  def show
    raise ActiveRecord::RecordNotFound if @namespace.portus?

    authorize @namespace
    @repositories = @namespace.repositories.page(params[:page])

    respond_with(@namespace)
  end

  # POST /namespace
  # POST /namespace.json
  def create
    @namespace = fetch_namespace
    authorize @namespace

    respond_to do |format|
      if @namespace.save
        @namespace.create_activity :create,
                                   owner:      current_user,
                                   parameters: { team: @namespace.team.name }
        @namespaces = policy_scope(Namespace)
        format.js { respond_with @namespace }
      else
        format.js { respond_with @namespace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /namespace/1
  # PATCH/PUT /namespace/1.json
  def update
    p = params.require(:namespace).permit(:name, :description, :team)
    change_name_description(@namespace, :namespace, p)

    # Update the team if needed/authorized.
    return if p[:team] == @namespace.team.name
    authorize @namespace, :change_team?

    @team = Team.find_by(name: p[:team])
    if @team.nil?
      @namespace.errors[:team_id] << "'#{p[:team]}' unknown."
    else
      @namespace.create_activity :change_team,
        owner:      current_user,
        parameters: { old: @namespace.team.id, new: @team.id }
      @namespace.update_attributes(team: @team)
    end
  end

  # GET /namespace/typeahead/%QUERY
  def typeahead
    @query = params[:query]
    valid_teams = TeamUser.get_valid_team_ids(current_user.id)
    matches = Team.search_from_query(valid_teams, "#{@query}%").pluck(:name)
    matches = matches.map { |team| { name: team } }
    respond_to do |format|
      format.json { render json: matches.to_json }
    end
  end

  # PATCH/PUT /namespace/1/change_visibility
  def change_visibility
    authorize @namespace

    # Update the visibility if needed
    return if params[:visibility] == @namespace.visibility

    return unless @namespace.update_attributes(visibility: params[:visibility])
    @namespace.create_activity :change_visibility,
      owner:      current_user,
      parameters: { visibility: @namespace.visibility }
    render template: "namespaces/change_visibility", locals: { namespace: @namespace }
  end

  private

  # Fetch the namespace to be created from the given parameters. Note that this
  # method assumes that the @team instance object has already been set.
  def fetch_namespace
    ns = params.require(:namespace).permit(:namespace, :description)

    @namespace = Namespace.new(
      team:       @team,
      name:       ns["namespace"],
      visibility: Namespace.visibilities[:visibility_private],
      registry:   Registry.get
    )
    @namespace.description = ns["description"] if ns["description"]
    @namespace
  end

  # Check that the given team exists and that is not hidden. This hook is used
  # only as a helper of the `create` method.
  def check_team
    @team = Team.find_by(name: params["namespace"]["team"], hidden: false)
    return unless @team.nil?

    @error = "Selected team does not exist."
    respond_to do |format|
      format.js { respond_with nil, status: :not_found }
    end
  end

  def check_role
    return false if current_user.admin? ||
        @team.owners.exists?(current_user.id) ||
        @team.contributors.exists?(current_user.id)

    @error = "You are not allowed to create a namespace for the team #{@team.name}."
    respond_to do |format|
      format.js { respond_with nil, status: :unauthorized }
    end
  end

  def set_namespace
    @namespace = Namespace.find(params[:id])
  end
end
