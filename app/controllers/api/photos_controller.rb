module Api
  class PhotosController < ApplicationController
    include PhotosHelper
    before_action :authenticate_user!, except: %i[index preview]
    before_action :set_photo, only: %i[edit update destroy preview show]

    def index
      @photos = Photo.published
      render json: @photos, each_serializer: PhotoSerializer
    end

    def show
      @comment = @photo.comments.build
      @comments = @photo.comments.all.includes(:user)
      render json: @photo, each_serializer: PhotoSerializer
    end

    private

    def photo_params
      params.require(:photo).permit(:name, :description, :image)
    end

    def set_photo
      @photo = Photo.find(params[:id])
    end
  end
end
