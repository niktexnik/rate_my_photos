class PhotosController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @photos = @user.photos.all
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.build
    @comments = @photo.comments.all
  end

  def new
    @user = User.find(current_user.id)
    @photo = @user.photos.new
  end

  def create
    # @user = User.find(current_user.id)
    # @photo = @user.photos.new(photo_params)
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:success] = 'Success'
      redirect_to @photo
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

  private

  def photo_params
    params.require(:photo).permit(:name, :description, :image)
  end
end
