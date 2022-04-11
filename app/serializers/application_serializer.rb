class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = {
    host: 'localhost:3000'
  }
end
