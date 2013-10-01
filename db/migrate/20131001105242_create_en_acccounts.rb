class CreateEnAcccounts < ActiveRecord::Migration
  def change
    create_table :en_acccounts do |t|
      t.string :user_account
      t.string :city
      t.string :street
      t.string :building
      t.string :apartment
      t.date :bypass
      t.integer :meter_reading
      t.float :invoice_amount
      t.date :data
    end
  end
end
