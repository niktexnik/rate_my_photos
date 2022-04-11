module Photos
  class Index < ActiveInteraction::Base
    FILTER_STRING = %w[pending rejected removed published].freeze
    object :user, default: nil
    string :search_string, default: nil
    string :order, :direction, default: nil
    string :filter, default: nil
    integer :page, default: nil
    string :controller

    def execute
      photos = controller == 'photos' ? Photo.published : user.photos.all
      photos = photos.public_send(filter) if filter&.in?(FILTER_STRING)
      photos = photos.filter_by(search_string) if given?(:search_string)
      photos = photos.ordered_by(order, direction) if given?(:order && :direction)
      photos = photos.page(page)
      photos
    end
  end
end
