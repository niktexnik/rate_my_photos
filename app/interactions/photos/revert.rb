module Photos
  class Revert < ActiveInteraction::Base
    object :photo

    def execute
      job_id = REDIS.get(photo.id)
      photo.revert!
      job = Sidekiq::ScheduledSet.new.find_job(job_id)
      job.delete
    end
  end
end
