class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_photo, only: %i[create destroy]

  def create
    @like = CreateLike.run(params.fetch(:like, {}).merge(user: current_user, photo: @photo))
    if @like.valid?
      respond_to do |format|
        format.js { render partial: 'likes/likes', locals: { photo: @photo, like: @like.result } }
        format.html { redirect_to preview_photo_url(@photo), notice: 'Liked!' }
      end
    else
      flash[:danger] = 'Error...'
      redirect_to preview_photo_url(@photo)
    end
  end

  def destroy
    @like = @photo.likes.find(params[:id])
    DestroyLike.run!(like: @like)
    respond_to do |format|
      format.js { render partial: 'likes/likes', locals: { photo: @photo, like: @like } }
      format.html { redirect_to preview_photo_url(@photo), notice: 'Like deleted!' }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
