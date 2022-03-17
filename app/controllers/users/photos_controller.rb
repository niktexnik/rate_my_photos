class Users::PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: %i[index preview]
  before_action :set_photo, only: %i[edit update destroy show]
  before_action :authorize_photo!
  after_action :verify_authorized

  def index
    @search = Photos::IndexCabinet.run(params.merge(user: current_user))
    @photos = @search.result
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
    @photo = Photos::Create.new
    respond_to do |format|
      format.js { render :new }
      format.html
    end
  end

  def create
    @photo = Photos::Create.run(params.fetch(:photo, {}).merge(user: current_user))
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
    @photo = Photos::Update.new(
      photo: photo,
      image: @photo.image,
      name: @photo.name,
      description: @photo.description
    )
    respond_to do |format|
      format.js { render :edit }
      format.html
    end
  end

  def update
    inputs = { photo: find_photo! }.reverse_merge(params[:photo])
    @photo = Photos::Update.run(inputs)
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
        title: 'Your comments on the photo will be deleted. Since it will be deleted within 5 minutes:',
        body: "Name: #{@photo.name}"
      )
    end

    NotificationsChannel.broadcast_to(
      @photo.user,
      title: 'Your photo has been sent for deletion. it will be deleted within 5 minutes:',
      body: "Name: #{@photo.name}"
    )
    respond_to do |format|
      format.js { render partial: 'photos' }
      format.html { redirect_to users_photos_url, notice: 'Deleted Success' }
    end
  end

  def restore
    @photo = Photo.find(params[:photo_id])
    @photo = Photos::Revert.run(photo: @photo)
    respond_to do |format|
      format.js { render partial: 'photos', notice: 'Restored' }
      format.html { redirect_to users_photos_url, notice: 'Restored' }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def find_photo!
    photo = Photos::Show.run(params)

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
