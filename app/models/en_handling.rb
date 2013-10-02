class EnHandling < ActiveRecord::Base
  attr_accessible :user_account, :user_id, :remote_ip, :created_at
end
