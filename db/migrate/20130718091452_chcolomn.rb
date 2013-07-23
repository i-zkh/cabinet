class Chcolomn < ActiveRecord::Migration
  def change
    connection.execute(%q{
        alter table vendors
        alter column auth_key
        type varchar using auth_key::varchar})
  end
end
