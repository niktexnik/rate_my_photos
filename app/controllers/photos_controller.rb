class PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    puts params
    @search = Photos::Index.run(params)
    @photos = @search.result
    respond_to do |format|
      format.js { render partial: 'photos_main' }
      format.html
    end
  end

  def preview
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.build
    @comments = @photo.comments.includes(:user)
    @like = @photo.likes.find_by(user: current_user)
    respond_to do |format|
      format.js { render partial: 'comments/comments_list' }
      format.html {}
    end
  end
end
