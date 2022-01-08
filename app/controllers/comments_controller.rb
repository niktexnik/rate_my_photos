class CommentsController < ApplicationController

before_action :set_comments

  def show; end

  def create
    @comment = @photo.comments.build comments_params
    if @comment.save
      flash[:success] = 'Success'
      redirect_to @photo
    else
      flash[:danger] = 'Not created...'
      render 'photos/show'
    end
  end

  def destroy; end

  private

  def set_comments
    @photo = Photo.find(params[:photo_id])
  end

  def comments_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
