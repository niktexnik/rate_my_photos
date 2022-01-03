class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.string :name
      t.text :description
      t.string :status
      t.boolean :moderated
      t.date :moderated_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
