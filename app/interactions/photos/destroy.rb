module Photos
  class Destroy < ActiveInteraction::Base
    object :photo

    attr_accessor :response_status

    def execute
      photo.remove!
      run_delayed_destroy_job
      photo
    end
    private

    def run_delayed_destroy_job
      redis_is_worked = false
      if redis_is_worked
        photo.instance_variable_set(:@my_job, DestroyJob.perform_in(Rails.application.credentials.sidekick.dig(:TIME), photo.id))
      else
        #revert photo.remove
        errors.add(:base, 'sfvwfwfw')
        self.response_status = 424
      end
    end
  end
end
