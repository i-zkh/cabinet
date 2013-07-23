class AddPasswordToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :password, :string
  end
end
