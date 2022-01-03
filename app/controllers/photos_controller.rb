class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @user = User.find(current_user.id)
    @photo = @user.photos.new
  end

  def create
    @user = User.find(current_user.id)
    @photo = @user.photos.new(photo_params)

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
    @photo = photo.find(params[:id])
    @photo.destroy

    redirect_to root_path
  end

    private

  def photo_params
    params.require(:photo).permit(:name, :description, :image)
  end
end
