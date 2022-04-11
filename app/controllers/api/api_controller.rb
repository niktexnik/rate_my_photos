module Api
  class ApiController < ActionController::API
    # serialization_scope :view_context
    serialization_scope :current_user
    include ExeptionsHandler
    include Pundit

    private

    def current_user
      @current_user ||= User.find_by(api_key: request.headers['token']) or raise Pundit::NotAuthorizedError
    end

    def pundit_user
      current_user
    end

    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    end
  end
end
