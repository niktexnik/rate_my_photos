module Photos
  class Destroy < ActiveInteraction::Base
    object :photo

    def execute
      time = Rails.application.credentials.sidekick.dig(:TIME)
      photo.remove!
      DestroyJob.perform_in(time, photo.id)
    end
  end
end
