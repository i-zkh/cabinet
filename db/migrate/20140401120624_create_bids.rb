class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :contract_number
      t.float :installation_payment
      t.string :installation_payment_for_vendor
      t.float :service_payment
      t.string :service_payment_for_vendor

      t.timestamps
    end
  end
end
