class Users::PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: %i[index]
  before_action :set_photo, only: %i[edit update destroy show]
  before_action :authorize_photo!
  after_action :verify_authorized

  def index
    puts params
    @search = Photos::Index.run(params.merge(user: current_user))
    @photos = @search.result
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  def new
    @photo = Photos::Create.new
    respond_to do |format|
      format.js { render :new }
      format.html
    end
  end

  def create
    @photo = Photos::Create.run(params[:photo].merge(user: current_user))
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
    respond_to do |format|
      format.js { render :edit }
      format.html
    end
  end

  def update
    @photo = Photos::Update.run(params[:photo].merge(photo: @photo))
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
    @outcome = Photos::Destroy.run!(photo: @photo)
    REDIS.set @photo.id, @outcome
    @photo.comments.each do |u|
      NotificationsChannel.broadcast_to(
        u.user,
        title: 'Your comments will be deleted. Photo:',
        body: "Name: #{@photo.name}"
      )
    end
  end

  def restore
    @photo = Photos::Revert.run(photo: Photo.find(params[:photo_id]))
    respond_to do |format|
      format.js { render partial: 'photos', notice: 'Restored' }
      format.html { redirect_to users_photos_url, notice: 'Restored' }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def authorize_photo!
    authorize [:users, @photo || Photo]
  end
end
