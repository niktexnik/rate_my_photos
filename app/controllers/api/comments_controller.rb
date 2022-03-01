module Api
  class CommentsController < ApplicationController
    before_action :set_commentable, except: %w[create index show]
    before_action :find_comment!, except: %w[create index show]
    def index
      render json: Comment.all, each_serializer: CommentSerializer
    end

    def show
      comment = FindComment.run(params)
      if comment.valid?
        render json: comment.result, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, each_serializer: CommentSerializer
      end
    end

    def create
      comment = CreateComment.run(params.fetch(:comment, {}).merge(user: current_user, commentable: @commentable))
      if comment.valid?
        render json: { message: 'Success', comment: comment.result }, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, each_serializer: CommentSerializer
      end
    end

    def destroy
      comment = DestroyComment.run!(comment: comment)
      if comment.valid?
        render json: { message: 'Success', comment: comment.result }, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, each_serializer: CommentSerializer
      end
    end

    def update
      inputs = { comment: find_comment! }.reverse_merge(params[:comment])
      comment = UpdateComment.run(inputs)
      if @comment.valid?
        render json: { message: 'Success', comment: comment.result }, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, each_serializer: CommentSerializer
      end
    end

    private

    def set_commentable
      @commentable =
        if params[:photo_id].present?
          Photo.find(params[:photo_id])
        elsif params[:comment_id].present?
          Comment.find(params[:comment_id])
        end
    end

    def find_comment!
      comment = FindComment.run(params)
      if comment.valid?
        comment.result
      else
        raise ActiveRecord::RecordNotFound, comment.errors.full_messages.to_sentence
      end
    end
  end
end
