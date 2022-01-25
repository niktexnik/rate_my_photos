class PhotosController < ApplicationController
  include PhotosHelper
  before_action :authenticate_user!, except: %i[index preview]
  before_action :set_photo, only: %i[edit update destroy preview show]

  # before_action :logged_in_user, only: %i[edit update destroy show]
  # before_action :correct_user, only: %i[edit update destroy show]
  # before_action :moderator_user, only: :destroy

  def index
    @photos = Photo.published
    if params.dig(:q, :search).present?
      @photos = @photos.where('name ILIKE :search or description ILIKE :search', search: "%#{params.dig(:q, :search)}%")
    elsif params[:order] == 'yearD'
      @photos = Photo.ordered_by_date_asc
    elsif params[:order] == 'yearU'
      @photos = Photo.ordered_by_date_desc
    elsif params[:order] == 'likesD'
      @photos = Photo.ordered_by_likes_asc
    elsif params[:order] == 'likesU'
      @photos = Photo.ordered_by_likes_desc
    elsif params[:order] == 'commentsD'
      @photos = Photo.ordered_by_comments_asc
    elsif params[:order] == 'commentsU'
      @photos = Photo.ordered_by_comments_desc
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
