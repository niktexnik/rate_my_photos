class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @photos = current_user.photos.all
  end

  def update_key
    @user = current_user
    @user.update_columns(api_key: generate_api_key)
    respond_to do |format|
      format.js { render partial: './users/photos/key', notice: 'Key updated!' }
      format.html { redirect_to users_photos_path, notice: 'Key updated!' }
    end
  end

  def generate_api_key
    SecureRandom.base58(24)
  end
end
