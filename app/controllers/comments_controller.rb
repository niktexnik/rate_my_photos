class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, except: :create
  before_action :authorize_comment!
  after_action :verify_authorized

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Updated'
      redirect_to preview_photo_url(@commentable)
    else
      flash[:danger] = 'Not updated...'
      render :edit
    end
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Success'
      CommentNotification.with(photo: @commentable).deliver(current_user) if @commentable.is_a?(Photo)
      WebNotificationsChannel.broadcast_to(
        current_user,
        title: 'New things!',
        body: 'All the news fit to print'
      )
      redirect_back fallback_location: '/'
    else
      flash[:danger] = 'Not created...'
      render 'photos/preview'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted!'
    redirect_back fallback_location: '/'
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :photo_id)
  end

  def set_commentable
    @commentable =
      if params[:photo_id].present?
        Photo.find(params[:photo_id])
      elsif params[:comment_id].present?
        Comment.find(params[:comment_id])
      end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment!
    authorize(@comment || Comment)
  end
end
