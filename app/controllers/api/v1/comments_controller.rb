module Api
  module V1
    class CommentsController < ::Api::ApiController
      before_action :api_auth
      def create
        comment = Comments::Create.run(params.merge(user: @current_user))
        if comment.valid?
          render json: { message: 'Success', comment: comment.result }, status: :created, each_serializer: CommentSerializer
        else
          render json: { message: 'Error', comment: comment.errors.details }, status: :unprocessable_entity, each_serializer: CommentSerializer
        end
      end

      def destroy
        comment = Comment.find(params[:id])
        raise Pundit::NotAuthorizedError unless @current_user.id == comment.user.id
        comment = Comments::Destroy.run!(comment: comment)
        if comment.valid?
          render json: { message: 'Success' }, status: :ok, each_serializer: CommentSerializer
        else
          render json: comment.errors.details, status: :unprocessable_entity, each_serializer: CommentSerializer
        end
      end

      def update
        comment = Comment.find(params[:id])
        raise Pundit::NotAuthorizedError unless @current_user.id == comment.user.id
        # inputs = { comment: comment }.reverse_merge(params[:comment])
        comment = Comments::Update.run(params.merge(comment: comment))
        if comment.valid?
          render json: { message: 'Success', comment: comment.result }, status: :ok, each_serializer: CommentSerializer
        else
          render json: comment.errors.details, status: :unprocessable_entity, each_serializer: CommentSerializer
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
