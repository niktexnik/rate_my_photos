# module Notification
  class LikesNotification < SendNotification
    attr_accessor :params
    def initialize(params = nil)
      @params = params
    end
    def like
      photo = Photo.find(params['photo_id'])
      like = Like.find(params['id'])
      puts "!!!!!!!!!!!!!!!!!#{photo}, #{like}, #{photo.user}"
      SendNotification.new(photo.user, 'Your photo was liked by user:', "#{like.user.name},
        Current likes count: #{photo.likes_count}").call
    end

    def unlike
      photo = Photo.find(params['photo_id'])
      like = Like.find(params['id'])
      puts "!!!!!!!!!!!!!!!!!#{photo}, #{like}, #{photo.user}"
      SendNotification.new(photo.user, 'Your photo was unliked by user:', "#{like.user.name},
        Current likes count: #{photo.likes_count}").call
    end
  end
# end
