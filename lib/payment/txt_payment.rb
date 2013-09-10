class TxtPayment < Payment
  attr_accessor :data

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    i = 0
    outFile = File.new("#{Vendor.find(@id).title}.txt", "w")
      @data.each do |d|
          #vendor = UserIdRange.where(user_account: @report['user_account'], vendor_id: @report['vendor_id']).first
          #  if vendor = ""
          #      error << data
          #  end
          outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
        end
      outFile.close
  end
end