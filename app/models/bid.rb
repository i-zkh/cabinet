class Bid < ActiveRecord::Base
  attr_accessible :contract_number, :email, :installation_payment, :installation_payment_for_vendor, :name, :phone, :service_payment, :service_payment_for_vendor
  validates :email, :name, :contract_number, presence: true
  before_create :get_key
  private
  def get_key
    self.key = Time.now.strftime('%Y%M%d%H%M%S')
  end
end
