class AddPayToBids < ActiveRecord::Migration
  def change
    add_column :bids, :pay, :boolean, :default => false
  end
end
