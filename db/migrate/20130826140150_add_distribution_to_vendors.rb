class AddDistributionToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :distribution, :boolean
  end
end
