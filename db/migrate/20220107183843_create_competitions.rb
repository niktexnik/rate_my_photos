class CreateCompetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :competitions do |t|
      t.string :competition_name
      t.text :competition_description
      t.string :competition_image
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
