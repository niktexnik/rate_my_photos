class PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @search = Photos::Index.run(params)
    ActionCable.server.broadcast('web_notification_channel', 'You have visited the welcome page.')
    @photos = @search.result
    respond_to do |format|
      format.js { render partial: 'photos_main' }
      format.html
    end
  end

  def preview
    @photo = find_photo!
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
    @like = @photo.likes.find_by(user: current_user)
    respond_to do |format|
      format.js { render partial: 'comments/comments_list' }
      format.html {}
    end
  end

  private

  def find_photo!
    outcome = Photos::Show.run(params)

    if outcome.valid?
      outcome.result
    else
      raise ActiveRecord::RecordNotFound, outcome.errors.full_messages.to_sentence
    end
  end
end
