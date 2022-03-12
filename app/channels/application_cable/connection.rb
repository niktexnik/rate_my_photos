# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#     identified_by :current_user

#     def connect
#       self.current_user = find_verified_user
#       logger.add_tags 'ActionCable', current_user.name
#     end

#     protected

#     def find_verified_user # this checks whether a user is authenticated with devise
#       if verified_user = env['warden'].user
#         verified_user
#       else
#         reject_unauthorized_connection
#       end
#     end
#   end
# end
# module ApplicationCable
#   class Connection < ActionCable::Connection::Base

#     identified_by :current_user

#     def connect
#       self.current_user = find_verified_user
#       logger.add_tags 'ActionCable', current_user.name
#     end

#     protected

#     def find_verified_user
#       verified_user = User.find_by(id: cookies.signed['user.id'])
#       if verified_user && cookies.signed['user.expires_at'] > Time.now
#         verified_user
#       else
#         reject_unauthorized_connection
#       end
#     end
#   end
# end
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', "Email: #{current_user.email}"
    end

    protected

    def find_verified_user
      if current_user = env['warden'].user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
