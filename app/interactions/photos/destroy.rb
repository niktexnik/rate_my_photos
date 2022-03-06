module Photos
  class Destroy < ActiveInteraction::Base
    object :photo
    TIME = 500.minutes

    def execute
      photo.remove!
      DestroyJob.perform_in(TIME, photo.id)
    end
  end
end
