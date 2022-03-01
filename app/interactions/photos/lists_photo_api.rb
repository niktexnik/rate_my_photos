class ListsPhotoApi < ActiveInteraction::Base
  string :q, default: nil
  string :sort, default: nil

  def execute
    @photos = Photo.published
    @photos = @photos.filter_by(q) if given?(:q)
    if given?(:sort)
      order, direction = sort.split('.')
      @photos = @photos.ordered_by(order, direction)
    end
    @photos
  end
end
