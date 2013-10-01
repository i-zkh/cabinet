class EnAcccount < ActiveRecord::Base
  attr_accessible :apartment, :building, :bypass, :city, :data, :invoice_amount, :meter_reading, :street, :user_account
end
