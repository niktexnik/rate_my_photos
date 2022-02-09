class Users::PhotosController < ApplicationController
  include PhotosHelper
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: %i[index preview]
  before_action :set_photo, only: %i[edit update destroy preview show]
  before_action :authorize_photo!
  after_action :verify_authorized

  def index
    @photos = current_user.photos.all
    if params.dig(:q, :search).present?
      @photos = @photos.where('name ILIKE :search or description ILIKE :search', search: "%#{params.dig(:q, :search)}%")
    end
    @photos = @photos.page(params[:page])
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html
    end
  end

  def show
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = CreatePhotoService.call(photo_params, current_user)
    if @photo.valid?
      flash[:success] = 'Success'
      redirect_to users_photo_url(@photo)
    else
      flash[:danger] = 'Not created...'
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js { render partial: 'form' }
      format.html
    end
  end

  def update
    @photo = UpdatePhotoService.call(photo_params, @photo)
    if @photo
    respond_to do |format|
      format.js { render partial: 'form' }
      format.html { redirect_to users_photo_url(@photo), notice: 'success' }
    end
      # flash[:success] = 'Success'
      # redirect_to users_photo_url(@photo)
    else
      flash[:danger] = 'Not created...'
      render :edit
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html { redirect_to users_photos_url, notice: 'Deleted Success' }
    end
    # flash[:success] = 'Deleted Success'
    # redirect_to users_photos_url
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :description, :image)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def authorize_photo!
    authorize(@photo || Photo)
  end
end
