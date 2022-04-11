module Api
  module V1
    class PhotosController < ::Api::ApiController
      after_action :verify_authorized, except: %i[index show]
      before_action :current_user, except: %i[index show]

      def index
        photos = Photos::IndexApi.run(params)
        render json: photos.result, meta: pagination_dict(photos.result),
               fields: %i[id name description likes_count comments_count thumb_url show_link],
               status: :ok, each_serializer: PhotoSerializer
      end

      def show
        photo = Photos::Show.run(params)
        render json: photo.result,
               fields: %i[id name description likes_count comments_count large_url comments],
               status: :ok, serializer: PhotoSerializer
      end

      def destroy
        photo = Photo.find(params[:id])
        authorize [:api, photo]
        photo = Photos::Destroy.run(params)
        if photo.valid?
          render json: { message: 'Success', photo: photo.result }, status: :no_content, each_serializer: PhotoSerializer
        else
          render json: { message: 'Error', photo: photo.errors.details }, status: :unprocessable_entity, serializer: PhotoSerializer
        end
      end

      def create
        authorize [:api, Photo]
        photo = Photos::Create.run(params.merge(user: @current_user))
        if photo.valid?
          render json: photo.result, status: :created, serializer: PhotoSerializer
        else
          render json: photo.errors.details, status: :unprocessable_entity, serializer: PhotoSerializer
        end
      end

      def update
        photo = Photo.find(params[:id])
        authorize [:api, photo]
        photo = Photos::Update.run(params.merge(photo: photo))
        if photo.valid?
          render json: { message: 'Success', photo: photo }, status: :ok, each_serializer: PhotoSerializer
        else
          render json: photo.errors.details, status: :unprocessable_entity, each_serializer: PhotoSerializer
        end
      end
    end
  end
end
