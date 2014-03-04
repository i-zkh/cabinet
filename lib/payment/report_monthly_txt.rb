#encoding: utf-8
class ReportMonthlyTxt < Payment
  attr_accessor :data

  def initialize(data, vendor_id)
    @data = data
    @vendor_id = vendor_id
  end

  def monthly
    filename = "/home/ubuntu/apps/project/shared/transactions/" + "#{Vendor.find(@vendor_id).title.gsub!(/"/, "")}.txt"
    outFile = File.new(filename, "w")
      @data.each do |d|
        address = Account.where(user_account: d['user_account'], vendor_id: @vendor_id).first
        if address
          outFile.puts("#{d['user_account']};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
        else
          outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
        end
      end
    outFile.close
    filename
  end
end