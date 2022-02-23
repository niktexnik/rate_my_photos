module Api
  class UsersController < ApplicationController
    def index
      render json: User.all, each_serializer: UserSerializer
    end

    def show
      render json: User.find(params[:id]), each_serializer: UserSerializer
    end

    private

    def api_auth
      
    end
  end
end
