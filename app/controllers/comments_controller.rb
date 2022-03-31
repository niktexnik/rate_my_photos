class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, except: :create
  before_action :authorize_comment!
  after_action :verify_authorized

  def update
    # inputs = { comment: set_comment }.reverse_merge(params[:comment])
    @comment = Comments::Update.run(params[:comment].merge(comment: @comment))
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
    @comment = Comments::Create.run(params[:comment].merge(user: @current_user).merge(comment_id: params[:comment_id]))
    if @comment.valid?
      redirect_back fallback_location: '/'
      flash[:success] = 'Success'
    else
      # redirect_back fallback_location: '/'
      flash[:danger] = 'Error'
    end
  end

  def destroy
    Comments::Destroy.run!(comment: @comment)
    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: '/', notice: 'Comment deleted!' }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment!
    authorize(@comment || Comment)
  end
end
