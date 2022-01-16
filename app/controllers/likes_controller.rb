class LikesController < ApplicationController
  before_action :set_like
  def create
    @like = @photo.likes.build
    @like.user = current_user
    if @like.save
      flash[:success] = 'Liked'
      redirect_to preview_photo_url(@photo)
    else
      flash[:danger] = 'Error...'
      # redirect_to preview_photo_url(@photo)
    end
  end

  def destroy
    @like = @photo.likes.find(params[:id])
    @like.destroy
    flash[:success] = 'Like deleted!'
    redirect_to preview_photo_url(@photo)
  end

  private

  # def like_params
  #   params.require(:like).permit(:likes_count)
  # end

  def set_like
    @photo = Photo.find(params[:photo_id])
  end
end
