module Api
  class LikesController < ApplicationController
    before_action :set_photo, only: %i[create destroy]

    def create
      like = CreateLike.run(params.fetch(:like, {}).merge(user: current_user, photo: @photo))
      if @like.valid?
        render json: like.result, each_serializer: LikeSerializer
      else
        render json: like.errors.details, each_serializer: LikeSerializer
      end
    end

    def destroy
      like = @photo.likes.find(params[:id])
      DestroyLike.run!(like: @like)
      if like.valid?
        render json: { message: 'Success', like: like.result }, each_serializer: LikeSerializer
      else
        render json: like.errors.details, each_serializer: LikeSerializer
      end
    end

    private

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end
  end
end
