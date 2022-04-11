module Api
  module V1
    class LikesController < ::Api::ApiController
      before_action :current_user
      before_action :set_photo
      after_action :verify_authorized

      def create
        authorize [:api, Like]
        like = Likes::Create.run(params.merge(user: @current_user, photo: @photo))
        if like.valid?
          render json: like.result, status: :created, each_serializer: LikeSerializer
        else
          render json: like.errors.details, status: :unprocessable_entity, each_serializer: LikeSerializer
        end
      end

      def destroy
        like = @photo.likes.find(params[:id])
        authorize [:api, @like]
        Likes::Destroy.run!(like: like)
        if photo.valid?
          render json: { message: 'Success', like: photo.result }, status: :ok, each_serializer: LikeSerializer
        else
          render json: like.errors.details, status: :unprocessable_entity, each_serializer: LikeSerializer
        end
      end

      private

      def set_photo
        @photo = Photo.find(params[:photo_id])
      end
    end
  end
end
