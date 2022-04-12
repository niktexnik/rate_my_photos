module ExceptionsHandlerWeb
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from Pundit::NotAuthorizedError, with: :render_403
    rescue_from ActiveRecord::RecordInvalid, with: :render_422
    rescue_from ActiveRecord::RecordNotSaved, with: :render_422
    rescue_from ActionController::InvalidAuthenticityToken, with: :render_422
  end

  def render_404
    render 'errors/404', status: 404
  end

  def render_403
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def render_422
    render 'errors/422', status: 422
  end

  def render_500
    render 'errors/500', status: 500
  end
end
