class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.integer :precinct_id
      t.string :street
      t.string :house

      t.timestamps
    end
  end
end
