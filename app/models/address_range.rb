class AddressRange < ActiveRecord::Base
  attr_accessible :city, :street, :building, :apartment, :vendor_id
  
  belongs_to :vendor
  has_many :payloads, as: :user
end
