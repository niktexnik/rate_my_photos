class ListsPhotoCabinet < ActiveInteraction::Base
  string :q, default: nil
  string :sort, default: nil
  integer :page, default: nil

  def execute
    @photos = Photo.all              #{@photos}"
    puts "QQQQQQ                       #{q.class}"
    puts "SORT                         #{sort.class}"
    puts "PAGE                         #{page.class}"

    @photos = @photos.filter_by(q) if given?(:q)
    @photos = @photos.sort if given?(:sort)
    @photos = @photos.page(page) if given?(:sort)
    @photos.page(page)
  end
end
