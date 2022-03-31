module Api
  class ApiController < ActionController::API
    include CustomExeptions

    private

    def api_auth
      token = request.headers['token']
      @current_user = User.find_by(api_key: token)
      raise Pundit::NotAuthorizedError if @current_user.nil?
    end
  end
end
