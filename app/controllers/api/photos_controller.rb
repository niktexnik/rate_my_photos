module Api
  class PhotosController < ApplicationController
    before_action :api_auth, except: %i[index show]
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_photo!, except: %i[index create show]

    def index
      photos = Photos::IndexApi.run(params)
      if photos.valid?
        photos = photos.result.includes(:comments).page(params.dig(:page, :number)).per(params.dig(:page, :size))
        render json: photos, meta: pagination_dict(photos), status: :ok, each_serializer: PhotoSerializer
      else
        render json: photos.errors.details, status: :bad_request, each_serializer: PhotoSerializer
      end
    end

    def show
      photo = Photos::Show.run(params)
      if photo.valid?
        render json: photo.result, status: :ok, each_serializer: PhotoSerializer
      else
        render json: photo.errors.details, status: :bad_request, each_serializer: PhotoSerializer
      end
    end

    def destroy
      photo = Photos::Destroy.run(params)
      if photo.valid?
        render json: { message: 'Success', photo: photo.result }, status: :ok, each_serializer: PhotoSerializer
      else
        render json: photo.errors.details, status: :bad_request, each_serializer: PhotoSerializer
      end
    end

    def create
      photo = Photo::Create.run(params.fetch(:photo, {}).merge(user: @current_user))
      if photo.valid?
        render json: { message: 'Success', photo: photo.result }, status: :ok, each_serializer: PhotoSerializer
      else
        render json: photo.errors.details, status: :bad_request, each_serializer: PhotoSerializer
      end
    end

    def update
      inputs = { photo: find_photo! }.reverse_merge(params[:photo])
      @photo = Photos::Update.run(inputs)
      if @photo.valid?
        render json: { message: 'Success', photo: photo.result }, status: :ok, each_serializer: PhotoSerializer
      else
        render json: photo.errors.details, status: :bad_request, each_serializer: PhotoSerializer
      end
    end

    private

    def find_photo!
      photo = Photos::Show.run(params)
      if photo.valid?
        photo.result
      else
        raise ActiveRecord::RecordNotFound, photo.errors.full_messages.to_sentence
      end
    end

    def pagination_dict(object)
      {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
      }
    end
  end
end
