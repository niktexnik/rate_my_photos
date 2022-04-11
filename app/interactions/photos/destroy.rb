module Photos
  class Destroy < ActiveInteraction::Base
    object :photo
    attr_reader :my_job

    def execute
      photo.remove!
      @my_job = DestroyJob.perform_in(Rails.application.credentials.sidekick.dig(:TIME), photo.id)
      photo
    end
  end
end
