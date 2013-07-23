class RemovePasswordFromVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :password
  end

  def down
    add_column :vendors, :password, :string
  end
end
