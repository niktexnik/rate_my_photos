module Photos
  class IndexApi < ActiveInteraction::Base
    string :search_string, default: nil
    string :order, :direction, default: nil
    integer :number, :size, default: nil

    def execute
      puts "!!!!!!!!!!!!!#{size}!!!!!!!!!!!!!#{number}"
      photos = Photo.published
      photos = photos.filter_by(search_string) if given?(:search_string)
      photos = photos.ordered_by(order, direction) if given?(:order && :direction)
      photos = photos.page(number).per(size).includes(:comments)
      photos
    end
  end
end
