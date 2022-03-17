ActiveAdmin.register_page 'Notification' do
  menu label: 'Notification'
  controller do
    def index
      @text_notification = params[:input]
      users = User.all
      users.each do |user|
        NotificationsChannel.broadcast_to(
          user,
          title: 'ADMIN NOTIFICATION:',
          body: @text_notification
        )
      end
    end
  end

  content title: 'Send notification' do
    form action: 'index', method: :get do |f|
      f.label 'Input text'
      f.input type: :text, name: :input
      # field to handle authenticity token
      # f.input type: :hidden, name: :authenticity_token
      f.button :submit, type: :submit
    end
  end
end
