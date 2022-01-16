class AddCountsColumnToPhoto < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :likes_count, :integer, default: 0, null: false
    add_column :photos, :comments_count, :integer, default: 0, null: false
  end
end
