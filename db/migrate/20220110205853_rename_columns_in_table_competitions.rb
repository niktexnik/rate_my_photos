class RenameColumnsInTableCompetitions < ActiveRecord::Migration[6.1]
  def change
    rename_column :competitions, :competition_name, :name
    rename_column :competitions, :competition_description, :description
    rename_column :competitions, :competition_image, :image
  end
end
