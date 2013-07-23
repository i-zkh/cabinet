class UserIdRange < ActiveRecord::Base
  attr_accessible :user_account, :vendor_id
  
  belongs_to :vendor
  
  has_many :payloads, as: :user
end