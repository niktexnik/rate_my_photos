class PhotosController < ApplicationController
  def index
    @photos = Photo.published
    @photos = @photos.filter_by(params.dig(:q, :search)) if params.dig(:q, :search).present?
    @photos = @photos.ordered_by(params[:order], params[:direction]) if [params[:order], params[:direction]].all?
    @photos = @photos.page(params[:page])
  end

  def preview
    set_photo
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
    @like = @photo.likes.find_by(user: current_user)
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :description, :image)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
