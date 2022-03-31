module Api
  module V1
    class UsersController < ::Api::ApiController
      def index
        render json: User.all, each_serializer: UserSerializer
      end

      def show
        render json: User.find(params[:id]), each_serializer: UserSerializer
      end
    end
  end
end