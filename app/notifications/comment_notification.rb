# To deliver this notification:
# CommentNotification.with(photo: @photo).deliver_later(current_user)
# CommentNotification.with(photo: @photo).deliver(User.all)
# Instantiate a new notification
# notification = CommentNotification.with(comment: @comment)
# Deliver notification in background job
# notification.deliver_later(@comment.photos.user_id)
# Deliver notification immediately
# notification.deliver(@comment.photos.user_id)
# Deliver notification to multiple recipients
# notification.deliver_later(User.all)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #

  # def to_database
  #   {
  #     type: self.class.name,
  #     params: params,
  #     account: Current.account
  #   }
  # end
  param :photo

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end
  #
  def url
    preview_photo_path(params[:photo])
  end
end
