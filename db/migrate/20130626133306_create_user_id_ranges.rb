class CreateUserIdRanges < ActiveRecord::Migration
  def change
    create_table :user_id_ranges do |t|
      t.integer :user_account
      t.integer :vendor_id

      t.timestamps
    end
  end
end
