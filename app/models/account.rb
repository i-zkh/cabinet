class Account < ActiveRecord::Base
  attr_accessible :apartment, :building, :city, :street, :user_account, :vendor_id, :invoice_amount

  belongs_to :vendor
end
