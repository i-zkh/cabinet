class CreateAddressRanges < ActiveRecord::Migration
  def change
    create_table :address_ranges do |t|
      t.string :city
      t.string :street
      t.integer :building
      t.integer :apartment
      t.integer :vendor_id
      t.timestamps
    end
  end
end
