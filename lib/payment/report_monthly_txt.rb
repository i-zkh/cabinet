class ReportMonthlyTxt < Payment
  attr_accessor :data

  def initialize(data, vendor_id)
    @data = data
    @vendor_id = vendor_id
  end

  def monthly
    outFile = File.new("report_monthly/1-2014/" + "#{Vendor.find(@vendor_id).title.gsub!(/"/, "")}.txt", "w")
      @data.each do |d|
        address = Account.where(user_account: d['user_account'], vendor_id: @vendor_id).first
        if address
          outFile.puts("#{d['user_account']};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
        else
          outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
        end
      end
    outFile.close
  end
end