class CommentsController < ApplicationController
  before_action :set_comments

  def show; end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = 'Updated'
      redirect_to preview_photo_url(@photo)
    else
      flash[:danger] = 'Not updated...'
      render :edit
    end
  end

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Success'
      redirect_to preview_photo_url(@photo)
    else
      flash[:danger] = 'Not created...'
      render 'photos/preview'
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted!'
    redirect_to preview_photo_url(@photo)
  end

  private

  def set_comments
    @photo = Photo.find(params[:photo_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
