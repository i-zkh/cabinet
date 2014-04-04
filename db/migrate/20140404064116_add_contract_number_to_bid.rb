class AddContractNumberToBid < ActiveRecord::Migration
  def change
    add_column :bids, :contract_number, :string
  end
end
