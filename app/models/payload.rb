class Payload < ActiveRecord::Base
  attr_accessible :invoice_amount, :invoice_date, :user_id, :user_type, :vendor_id
  
  belongs_to :vendor
  belongs_to :user, polymorphic: true
  
end
