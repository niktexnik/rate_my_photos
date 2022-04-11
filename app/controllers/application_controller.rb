class ApplicationController < ActionController::Base
  include Pundit
  include ExeptionsHandlerWeb

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image uid provider])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image uid provider])
  end
end
