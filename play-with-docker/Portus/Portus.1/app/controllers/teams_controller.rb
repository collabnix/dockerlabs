class TeamsController < ApplicationController
  include ChangeNameDescription

  before_action :set_team, only: [:show, :update, :typeahead]
  after_action :verify_policy_scoped, only: :index
  respond_to :js, :html

  # GET /teams
  def index
    @teams = policy_scope(Team).page(params[:page])
    respond_with(@teams)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    raise ActiveRecord::RecordNotFound if @team.hidden?

    authorize @team
    @team_users = @team.team_users.enabled.page(params[:users_page]).per(10)
    @team_namespaces = @team.namespaces.page(params[:namespaces_page]).per(15)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = fetch_team
    authorize @team
    @team.owners << current_user

    if @team.save
      @team.create_activity(:create,
                            owner:      current_user,
                            parameters: { team: @team.name })
      respond_with(@team)
    else
      respond_with @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    p = params.require(:team).permit(:name, :description)
    change_name_description(@team, :team, p, team: @team.name)
  end

  # GET /teams/1/typeahead/%QUERY
  def typeahead
    authorize @team
    @query = params[:query]
    matches = User.search_from_query(@team.member_ids, "#{@query}%").pluck(:username)
    matches = matches.map { |user| { name: user } }
    respond_to do |format|
      format.json { render json: matches.to_json }
    end
  end

  # GET /teams/typeahead/%QUERY
  def all_with_query
    query = "#{params[:query]}%"
    teams = policy_scope(Team).where("name LIKE ?", query).pluck(:name)
    matches = teams.map { |t| { name: t } }
    respond_to do |format|
      format.json { render json: matches.to_json }
    end
  end

  private

  # Fetch the team to be created from the given parameters.
  def fetch_team
    team = params.require(:team).permit(:name, :description)

    @team = Team.new(name: team["name"])
    @team.description = team["description"] if team["description"]
    @team
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
