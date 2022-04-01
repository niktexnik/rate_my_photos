class ErrorsController < ApplicationController
  def not_found
    respond_to do |f|
      f.html { render 'errors/404', status: 404 }
      f.json { render json: { error: { message: 'Resourse not found', code: 404 } }, status: :not_found }
    end
  end

  def internal_server
    respond_to do |f|
      f.html { render 'errors/500', status: 500 }
      f.json { render json: { error: { message: 'Sorry... Server error', code: 500 } }, status: :internal_server_error }
    end
  end

  def unprocessable
    respond_to do |f|
      f.html { render 'errors/422', status: 422 }
      f.json {  }
    end
  end

  def unauthorized
    respond_to do |f|
      f.json { render json: { error: { message: 'Access denied', code: 401 } }, status: :unauthorized }
    end
  end
end
