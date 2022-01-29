class DeleteCommentsCountFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :comments_count
    add_column :comments, :photo_id, :bigint, index: true, null: false
  end
end
