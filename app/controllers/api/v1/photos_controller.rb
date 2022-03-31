module Api
  module V1
    class PhotosController < ::Api::ApiController
      before_action :api_auth, except: %i[index show]

      def index
        photos = Photos::IndexApi.run(params)
        if photos.valid?
          photos = photos.result.includes(:comments).page(params.dig(:page, :number)).per(params.dig(:page, :size))
          # photos = photos.result.includes(:comments)
          render json: photos, meta: pagination_dict(photos), status: :ok, each_serializer: PhotoSerializer
        else
          render json: photos.errors.details, status: :bad_request, each_serializer: PhotoSerializer
        end
      end

      def show
        photo = Photos::Show.run(params)
        if photo.valid?
          render json: photo.result, status: :ok, serializer: PhotoSerializer
        else
          render json: photo.errors.details, status: :bad_request, each_serializer: PhotoSerializer
        end
      end

      def destroy
        photo = Photo.find(params[:id])
        raise Pundit::NotAuthorizedError unless @current_user.id == photo.user.id

        photo = Photos::Destroy.run(params)
        if photo.valid?
          render json: { message: 'Success', photo: photo.result }, status: :ok, each_serializer: PhotoSerializer
        else
          render json: { message: 'Error', photo: photo.errors.details }, status: :unprocessable_entity, serializer: PhotoSerializer
        end
      end

      def create
        photo = Photos::Create.run(params.merge(user: @current_user))
        if photo.valid?
          render json: { message: 'Success', photo: photo.result }, status: :created, each_serializer: PhotoSerializer
        else
          render json: photo.errors.details, status: :unprocessable_entity, each_serializer: PhotoSerializer
        end
      end

      def update
        photo = Photo.find(params[:id])
        raise Pundit::NotAuthorizedError unless @current_user.id == photo.user.id
        photo = Photos::Update.run(params.merge(photo: photo))
        if photo.valid?
          render json: { message: 'Success', photo: photo }, status: :ok, each_serializer: PhotoSerializer
        else
          render json: photo.errors.details, status: :unprocessable_entity, each_serializer: PhotoSerializer
        end
      end

      private

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
end
