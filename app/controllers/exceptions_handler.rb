module ExceptionsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |e|
      render json: { error: { message: 'Sorry... Server error', details: e.message, code: 500 } }, status: :internal_server_error
    end

    rescue_from ActionController::InvalidAuthenticityToken do |e|
      render json: { error: { message: 'Resourse not found', details: e.message, code: 403 } }, status: :forbidden
    end

    rescue_from ActiveRecord::RecordNotFound || ActionController::RoutingError ||
                AbstractController::ActionNotFound || ActionController::UnknownController do |e|
      render json: { error: { message: 'Resourse not found', details: e.message, code: 404 } }, status: :not_found
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      render json: { error: { message: 'Access denied', details: e.message, code: 401 } }, status: :unauthorized
    end
  end
end