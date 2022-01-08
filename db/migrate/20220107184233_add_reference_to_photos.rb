class AddReferenceToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_reference :photos, :competition, null: false, foreign_key: true
  end
end
