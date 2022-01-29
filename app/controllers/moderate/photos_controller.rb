class Moderate::PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo, only: %i[edit update show]
  before_action :authorize_photo!
  after_action :verify_authorized

  def index
    @photos = Photo.all
    if params[:order] == 'published'
      @photos = Photo.published
    elsif params[:order] == 'rejected'
      @photos = Photo.rejected
    elsif params[:order] == 'pending'
      @photos = Photo.pending
    end
    @photos = @photos.page(params[:page])
  end

  def show; end

  def edit; end

  def update
    @photo = UpdatePhotoService.call(photo_params, @photo)
    if @photo
      flash[:success] = 'Success'
      redirect_to moderate_photos_url
    else
      flash[:danger] = 'Not created...'
      render :edit
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:name, :description, :status, :rejection_reason, :image)
  end

  def authorize_photo!
    authorize(@photo || Photo)
  end
end
