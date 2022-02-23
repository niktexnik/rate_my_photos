class ListsPhotoCabinet < ActiveInteraction::Base
  string :q, default: nil
  string :sort, default: nil
  integer :page, default: nil
  object :user

  def execute
    @photos = user.photos.all
    @photos = @photos.filter_by(q) if given?(:q)
    @photos = @photos.sort if given?(:sort)
    @photos = @photos.page(page) if given?(:sort)
    @photos.page(page)
  end
end
