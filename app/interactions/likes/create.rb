module Likes
  class Create < ActiveInteraction::Base
    object :photo, :user

    def execute
      errors.merge!(like.errors) unless like = photo.likes.create(inputs)
      like
    end
  end
end
