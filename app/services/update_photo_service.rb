class UpdatePhotoService < ApplicationService
  attr_reader :params, :photo
  def initialize(params, photo)
    @params = params
    @photo = photo
  end

  def call
    photo.update(params)
    photo
  end
end
