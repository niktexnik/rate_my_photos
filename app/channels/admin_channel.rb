class AdminChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'admin_channel'
  end

  def unsubscribed
    stop_all_streams
  end
end
