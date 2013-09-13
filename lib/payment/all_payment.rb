class AllPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    reportFile = File.new("report.txt", "w")
      @data.each do |d|
         reportFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%Y-%m-%d")};#{d['vendor_id']}")
      end
    reportFile.close
    ReportMail.report.deliver
  end
end