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
    @competition = Competition.find(params[:competition_id])
    @photo = @competition.photos.build
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @photo = @competition.photos.build(photo_params)

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

  def preview
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :description, :image).merge(user_id: current_user.id)
  end
end
