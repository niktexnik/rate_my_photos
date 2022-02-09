module Api
  class CommentsController < ApplicationController
    def index
      render json: Comment.all, each_serializer: CommentSerializer
    end
  end
end
