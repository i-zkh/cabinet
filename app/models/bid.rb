class Bid < ActiveRecord::Base
  attr_accessible :contract_number, :email, :installation_payment, :installation_payment_for_vendor, :name, :phone, :service_payment, :service_payment_for_vendor
end
