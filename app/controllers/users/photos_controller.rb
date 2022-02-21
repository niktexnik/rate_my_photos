class Users::PhotosController < ApplicationController
  include PhotosHelper
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: %i[index preview]
  before_action :set_photo, only: %i[edit update destroy show]
  before_action :authorize_photo!
  after_action :verify_authorized

  def index
    puts "PARAMS                       #{params}"
    @search = ListsPhotoCabinet.run(params)
    puts "SEARCH                       #{@search}"
    @photos = @search.result
    puts "PHOTO                       #{@photos}"
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html
    end
  end

  def show
    @comment = @photo.comments.build
    @comments = @photo.comments.all.includes(:user)
    respond_to do |format|
      format.js { render :show }
      format.html
    end
  end

  def new
    @photo = CreatePhoto.new
    respond_to do |format|
      format.js { render :new }
      format.html
    end
  end

  def create
    @photo = CreatePhoto.run(params.fetch(:photo, {}).merge(user: current_user))
    respond_to do |format|
      if @photo.valid?
        format.js { render partial: 'photos', notice: 'Success' }
        format.html { redirect_to users_photo_url(@photo.result), notice: 'Success' }
      else
        format.js { render :new }
        format.html { render :new, notice: 'Not created...' }
      end
    end
  end

  def edit
    photo = find_photo!
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1) Photo from controller edit: #{photo}"
    @photo = UpdatePhoto.new(
      photo: photo,
      image: @photo.image,
      name: @photo.name,
      description: @photo.description
    )
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2) Photo from controller edit: #{@photo}"
    respond_to do |format|
      format.js { render :edit }
      format.html
    end
  end

  def update
    inputs = { photo: find_photo! }.reverse_merge(params[:photo])
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1) Inputs from controller update: #{inputs}"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1) PHOTO from controller update: #{params[:photo]}"

    @photo = UpdatePhoto.run(inputs)
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2) Photo from controller update: #{@photo}"
    respond_to do |format|
      if @photo.valid?
        format.js { render partial: 'photos', notice: 'success' }
        format.html { redirect_to users_photo_url(@photo.result), notice: 'success' }
      else
        format.js { render :edit }
        format.html { render :edit, notice: 'Not created...' }
      end
    end
  end

  def destroy
    @photos = current_user.photos.all
    DestroyPhoto.run!(photo: @photo)
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html { redirect_to users_photos_url, notice: 'Deleted Success' }
    end
  end

  private

  # def photo_params
  #   params.require(:photo).permit(:name, :description, :image)
  # end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def find_photo!
    photo = FindPhoto.run(params)

    if photo.valid?
      photo.result
    else
      raise ActiveRecord::RecordNotFound, photo.errors.full_messages.to_sentence
    end
  end

  def authorize_photo!
    authorize(@photo || Photo)
  end
end
