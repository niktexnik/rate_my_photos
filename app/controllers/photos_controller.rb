class PhotosController < ApplicationController
  include PhotosHelper
  before_action :authenticate_user!, except: %i[index preview]
  before_action :set_photo, only: %i[edit update destroy preview show]

  def index
    @photos = Photo.published
    if params.dig(:q, :search).present?
      @photos = @photos.where('name ILIKE :search or description ILIKE :search', search: "%#{params.dig(:q, :search)}%")
    elsif params[:order].present? && params[:direction].present?
      @photos = Photo.ordered_by(params[:order], params[:direction])
    end
    @photos = @photos.page(params[:page])
  end

  def preview
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :description, :image)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
