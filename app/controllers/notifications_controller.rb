class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
  end

  def create
    CommentNotification.with(photo: @photo).deliver_later(current_user)
  end

  # private

  # def notifications_params
  #   params.permit(:recipient_id, :recipient_type)
  # end
end
