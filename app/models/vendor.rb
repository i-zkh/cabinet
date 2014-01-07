class Vendor < ActiveRecord::Base
  attr_accessible :account_number, :auth_key, :merchantId, :service_type_id, :title, :user_id_type, :vendor_type, :commission, :email, :distribution

  has_many :user_id_ranges
  has_many :payloads
  has_many :address_ranges
  has_many :accounts
end
