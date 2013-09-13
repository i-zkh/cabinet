class AddColumnAmountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :invoice_amount, :float
  end
end
