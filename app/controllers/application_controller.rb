class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # def self.render_with_signed_in_user(user, *args)
  #   ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
  #   proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
  #   renderer = self.renderer.new('warden' => proxy)
  #   renderer.render(*args)
  # end

  private

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image uid provider])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image uid provider])
  end

  private

  def api_auth
    token = request.headers['token']
    @current_user = User.find_by(api_key: token)
    head 401
  end
end
