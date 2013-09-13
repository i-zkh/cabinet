class Booker < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    bookerFile = File.new("transactions.txt", "w")
      @data.each do |d|
        vendor = Vendor.find(id: d['vendor_id'])
        address = UserIdRange.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
           if address != nil
            address = Account.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
           if address != nil
              bookerFile.puts("#{vendor.title}  #{d['user_account']};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
            else
              bookerFile.puts("#{vendor.title}  #{d['user_account']};#{d['address']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
            end
           end
      end
    bookerFile.close
    ReportMail.booker.deliver
  end
end