module Photos
  class Index < ActiveInteraction::Base
    string :search_string, default: nil
    string :order, :direction, default: nil
    integer :page, default: nil

    def execute
      @photos = Photo.published
      @photos = @photos.filter_by(search_string) if given?(:search_string)
      @photos = @photos.ordered_by(order, direction) if given?(:order && :direction)
      @photos = @photos.page(page)
    end
  end
end
