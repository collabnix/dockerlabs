class CommentsController < ApplicationController
  before_action :set_repository
  respond_to :js, :html

  # POST /repositories/1/comments
  # POST /repositories/1/comments.json
  def create
    @comment = @repository.comments.new(params.require(:comment).permit(:body))
    @comment.author = current_user
    authorize @comment

    if @comment.save
      respond_with(@comment)
    else
      respond_with @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /repositories/1/comments/1
  # DELETE /repositories/1/comments/1.json
  def destroy
    @comment = @repository.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    respond_with @comment
  end

  private

  def set_repository
    @repository = Repository.find(params[:repository_id])
  end
end
