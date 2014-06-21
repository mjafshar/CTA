class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :stop_id
      t.string :on_street
      t.string :cross_street
      t.integer :boardings
      t.integer :alightings
      t.string :month_beginning
      t.string :daytype
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
