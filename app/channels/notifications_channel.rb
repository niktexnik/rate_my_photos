class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'notifications_channel'
  end
end
