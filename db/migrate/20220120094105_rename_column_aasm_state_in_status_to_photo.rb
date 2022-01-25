class RenameColumnAasmStateInStatusToPhoto < ActiveRecord::Migration[6.1]
  def change
    rename_column :photos, :aasm_state, :status
  end
end
