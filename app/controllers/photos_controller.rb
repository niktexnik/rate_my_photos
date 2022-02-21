class PhotosController < ApplicationController
  def index
    @search = ListsPhoto.run(params)
    @photos = @search.result
  end

  def preview
    @photo = find_photo!
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
    @like = @photo.likes.find_by(user: current_user)
  end

  private

  def find_photo!
    outcome = FindPhoto.run(params)

    if outcome.valid?
      outcome.result
    else
      raise ActiveRecord::RecordNotFound, outcome.errors.full_messages.to_sentence
    end
  end
end
