class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :user_account
      t.string :city
      t.string :street
      t.string :building
      t.string :apartment
      t.integer :vendor_id

      t.timestamps
    end
  end
end
