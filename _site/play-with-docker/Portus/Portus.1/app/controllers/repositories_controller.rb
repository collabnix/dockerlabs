class RepositoriesController < ApplicationController
  include Deletable

  before_action :set_repository, only: [:show, :destroy, :toggle_star]

  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = policy_scope(Repository).all
    respond_with(@repositories)
  end

  # GET /repositories/1
  # GET /repositories/1.json
  def show
    authorize @repository
    @tags = @repository.groupped_tags
    @repository_comments = @repository.comments.all
    respond_with(@repository)
  end

  # POST /repositories/toggle_star
  def toggle_star
    @repository.toggle_star current_user
    render template: "repositories/star", locals: { user: current_user }
  end

  # Removes all the tags that belong to this repository, and removes it.
  def destroy
    authorize @repository

    # First of all we mark the repo and the tags, so we don't have concurrency
    # problems when "delete" events come in.
    @repository.tags.update_all(marked: true)
    @repository.update_attributes(marked: true)

    # Remove all tags, effectively removing them from the registry too.
    @repository.groupped_tags.map { |t| t.first.delete_by_digest!(current_user) }

    # Delete this repository if all tags were successfully deleted.
    if @repository.reload.tags.any?
      ts = @repository.tags.pluck(:name).join(", ")
      logger.error "The following tags could not be removed: #{ts}."
      redirect_to repository_path(@repository), alert: "Could not remove all the tags", float: true
    else
      @repository.delete_and_update!(current_user)
      redirect_to namespace_path(@repository.namespace),
        notice: "Repository removed with all its tags", float: true
    end
  end

  protected

  def set_repository
    @repository = Repository.find(params[:id])
  end
end
