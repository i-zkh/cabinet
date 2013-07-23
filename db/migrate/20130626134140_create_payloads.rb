class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :user_id
      t.string :user_type
      t.float :invoice_amount
      t.integer :invoice_date
      t.integer :vendor_id

      t.timestamps
    end
  end
end
