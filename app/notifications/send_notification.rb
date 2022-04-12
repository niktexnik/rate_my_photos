# module Notifications
  class SendNotification
    DEFAULT_BODY = 'Test Body'.freeze
    DEFAULT_TITLE = 'Test Title'.freeze
    DEFAULT_CONSUMER = User.last
    attr_accessor :title, :body, :consumer
    def initialize(consumer = DEFAULT_CONSUMER, title = DEFAULT_TITLE, body = DEFAULT_BODY)
      @title = title
      @body = body
      @consumer = consumer
    end

    def call
      NotificationsChannel.broadcast_to(
        consumer,
        title: title,
        body: body
      )
    end
  end
  #end