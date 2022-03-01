class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_commentable
  before_action :set_comment, except: :create
  before_action :authorize_comment!
  after_action :verify_authorized

  def update
    inputs = { comment: set_comment }.reverse_merge(params[:comment])
    @comment = UpdateComment.run(inputs)
    respond_to do |format|
      if @comment.valid?
        format.html { redirect_to preview_photo_url(@commentable), notice: 'Updated' }
      else
        format.html { render :edit, notice: ' Not Updated' }
      end
      format.js { render :edit }
    end
  end

  def create
    @comment = CreateComment.run(params.fetch(:comment, {}).merge(user: current_user, commentable: @commentable))
    if @comment.valid?
      flash[:success] = 'Success'
      redirect_back fallback_location: '/'
    else
      flash[:danger] = 'Not created...'
      render 'photos/preview'
    end
  end

  def destroy
    DestroyComment.run!(comment: @comment)
    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: '/', notice: 'Comment deleted!' }
    end
  end

  private

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
