class VenderTypeToStr < ActiveRecord::Migration
   def change
    connection.execute(%q{
        alter table vendors
        alter column vendor_type
        type varchar using vendor_type::varchar})
  end
end
