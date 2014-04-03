class Bid < ActiveRecord::Base
  attr_accessible :contract_number, :email, :installation_payment, :installation_payment_for_vendor, :name, :phone, :service_payment, :service_payment_for_vendor
  validates :email, presence: true
  after_initialize :get_key
  private
  def get_key
    self.key = Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)
  end
end
