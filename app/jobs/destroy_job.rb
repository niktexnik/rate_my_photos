class DestroyJob
  include Sidekiq::Job
  queue_as :default
  sidekiq_options retry: 3

  def perform(photo_id)
    photo = Photo.find(photo_id)
    photo.destroy
  end
end
