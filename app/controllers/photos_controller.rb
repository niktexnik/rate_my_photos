class PhotosController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy show]
  before_action :correct_user, only: %i[edit update destroy show]
  before_action :moderator_user, only: :destroy
  def index
    # @photos = Photo.page(params[:page])
    @photos = Photo.published.page(params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
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

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

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
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:success] = 'Deleted Success'
    redirect_to root_path
  end

  def preview
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  private

  def logged_in_user
    unless signed_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to user_session_path
    end
  end

  def correct_user
    @photo = Photo.find(params[:id])
    @user = @photo.user_id
    redirect_to(root_url) unless @user == current_user.id
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def moderator_user
    redirect_to(root_url) unless current_user.moderator?
  end

  def photo_params
    params.require(:photo).permit(:name, :description, :image, :aasm_state)
  end
end
