class AddColumnToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :aasm_state, :string
    add_column :photos, :rejection_reason, :text
  end
end
