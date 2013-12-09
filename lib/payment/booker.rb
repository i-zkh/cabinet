class Booker < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    bookerFile = File.new("transactions.txt", "w")
      @data.each do |d|
        vendor = Vendor.find(d['vendor_id'])
        bookerFile.puts("#{vendor.title}  #{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
      end
      bookerFile.close

      unless File.zero?("transactions.txt")
        ReportMail.booker("pakhomova@izkh.ru").deliver
        ReportMail.booker("yusova@izkh.ru").deliver
        ReportMail.booker("Gluhovskaya.o@delta.ru").deliver
        ReportMail.booker("ivanova@izkh.ru").deliver
      end
  end
end