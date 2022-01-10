class CommentsController < ApplicationController
  before_action :set_comments

  def show; end

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Success'
      redirect_to preview_competition_photo_url(@photo.competition, @photo)
    else
      flash[:danger] = 'Not created...'
      render 'photos/preview'
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted!'
    redirect_to @photo
  end

  private

  def set_comments
    @photo = Photo.find(params[:photo_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
