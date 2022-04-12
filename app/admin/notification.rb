ActiveAdmin.register_page 'Notification' do
  menu label: 'Notification'
  controller do
    def index
      ActionCable.server.broadcast 'admin_channel', {
        title: 'ADMIN NOTIFICATION:',
        body: params[:input]
      }
    end
  end

  content title: 'Send notification' do
    form action: 'index', method: :get do |f|
      f.label 'Input text'
      f.input type: :text, name: :input
      f.button :submit, type: :submit
    end
  end
end
