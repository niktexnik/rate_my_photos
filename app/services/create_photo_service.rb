class CreatePhotoService < ApplicationService
  attr_reader :params, :current_user
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    photo = current_user.photos.build(params)
    photo.save
    photo
  end
end
