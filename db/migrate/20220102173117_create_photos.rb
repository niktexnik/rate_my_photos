class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.string :image_new
      t.string :name, null: false
      t.text :description, null: false
      t.string :aasm_state
      t.text :rejection_reason
      t.date :moderated_date

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
