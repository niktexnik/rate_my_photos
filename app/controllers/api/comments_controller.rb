module Api
  class CommentsController < ApplicationController
    before_action :set_commentable, except: %w[create index show]
    before_action :find_comment!, except: %w[create index show]
    def index
      render json: Comment.all, status: :ok, each_serializer: CommentSerializer
    end

    def show
      comment = Comments::Show.run(params)
      if comment.valid?
        render json: comment.result, status: :ok, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, status: :bad_request, each_serializer: CommentSerializer
      end
    end

    def create
      comment = Comments::Create.run(params.fetch(:comment, {}).merge(user: @current_user, commentable: @commentable))
      if comment.valid?
        render json: { message: 'Success', comment: comment.result }, status: :ok, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, status: :bad_request, each_serializer: CommentSerializer
      end
    end

    def destroy
      comment = Comments::Desroy.run!(comment: comment)
      if comment.valid?
        render json: { message: 'Success', comment: comment.result }, status: :ok, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, status: :bad_request, each_serializer: CommentSerializer
      end
    end

    def update
      inputs = { comment: find_comment! }.reverse_merge(params[:comment])
      comment = Comments::Update.run(inputs)
      if @comment.valid?
        render json: { message: 'Success', comment: comment.result }, status: :ok, each_serializer: CommentSerializer
      else
        render json: comment.errors.details, status: :bad_request, each_serializer: CommentSerializer
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
      comment = Comment::Show.run(params)
      if comment.valid?
        comment.result
      else
        raise ActiveRecord::RecordNotFound, comment.errors.full_messages.to_sentence
      end
    end
  end
end
