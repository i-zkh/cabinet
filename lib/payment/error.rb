class Error < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  # Daily report
  def output
    error = []
    @data.each do |d|
      address = Account.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
      error << "#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%Y-%m-%d")};#{d['vendor_id']}" if address == nil
    end
       ReportMail.error(error, "[ERROR] user accounts").deliver unless error.empty?
  end
end