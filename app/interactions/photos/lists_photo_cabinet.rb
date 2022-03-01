class ListsPhotoCabinet < ActiveInteraction::Base
  string :q, default: nil
  string :sort, default: nil
  integer :page, default: nil
  object :user

  def execute
    @photos = user.photos.all
    @photos = @photos.filter_by(q) if given?(:q)
    if given?(:sort)
      @photos = @photos.pending if sort == 'pending'
      @photos = @photos.published if sort == 'published'
      @photos = @photos.rejected if sort == 'rejected'
      @photos = @photos.deleted if sort == 'deleted'
    end
    @photos = @photos.page(page)
  end
end
