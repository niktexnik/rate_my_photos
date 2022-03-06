module Likes
  class Create < ActiveInteraction::Base
    object :photo, :user

    def execute
      like = photo.likes.create(inputs)
      errors.merge!(like.errors) unless like.save

      like
    end
  end
end
