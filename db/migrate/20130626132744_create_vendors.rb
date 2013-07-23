class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :title
      t.integer :account_number
      t.integer :user_id_type
      t.integer :vendor_type
      t.integer :merchantId
      t.integer :service_type_id
      t.integer :auth_key

      t.timestamps
    end
  end
end
