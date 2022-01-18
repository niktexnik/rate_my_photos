class PhotosController < ApplicationController
  include PhotosHelper
  before_action :set_photo, only: %i[edit update destroy preview]
  before_action :logged_in_user, only: %i[edit update destroy show]
  before_action :correct_user, only: %i[edit update destroy show]
  before_action :moderator_user, only: :destroy

  def index
    # @photos = Photo.page(params[:page])
    # @photos = Photo.published.page(params[:page])
    @q = Photo.ransack(params[:q])
    @photos = @q.result.published.page(params[:page])
  end

  def show
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:success] = 'Success'
      redirect_to @photo
      # redirect_back_or @photo
    else
      flash[:danger] = 'Not created...'
      render :new
    end
  end

  def edit; end

  def update
    if @photo.update(photo_params)
      flash[:success] = 'Updated'
      redirect_to @photo
      # redirect_back_or @photo
    else
      flash[:danger] = 'Not updated...'
      render :edit
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = 'Deleted Success'
    redirect_to root_path
  end

  def preview
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:name, :description, :image, :aasm_state)
  end
end
