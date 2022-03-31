module Photos
  class IndexCabinet < ActiveInteraction::Base
    SORT_STRING = %w[pending rejected removed published].freeze
    string :search_string, default: nil
    string :sort, default: nil
    integer :page, default: nil
    object :user

    def execute
      @photos = user.photos.all
      @photos = @photos.filter_by(search_string) if given?(:search_string)
      @photos = @photos.public_send(sort) if sort.in?(SORT_STRING) && given?(:sort)
      @photos = @photos.page(page)
    end
  end
end
