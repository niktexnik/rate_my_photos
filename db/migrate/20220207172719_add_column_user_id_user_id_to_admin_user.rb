class AddColumnUserIdUserIdToAdminUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :admin_users, :user, foreign_key: true
  end
end
