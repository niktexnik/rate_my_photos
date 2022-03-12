class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(notificationID)
    notification = Notification.find_by_id(notificationID)
    user = User.find_by_id(notification.target_id)
    ActionCable.server.broadcast 'notifications_#{notification.target_id}', render_notification(user, notification)
  end
  private
  def render_notification(user, notification)
    ApplicationController.render_with_signed_in_user(user, partial: 'notifications/index')
  end
end