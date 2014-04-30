class AllPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    reportFile = File.new("report.txt", "w")
    @data.each { |d| reportFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{d['date'].nil? ? DateTime.parse(d['created_at']).strftime("%d.%m.%Y") : DateTime.parse(d['date']).strftime("%d.%m.%Y")};#{d['vendor_id']}") }
    reportFile.close
    ReportMail.report_to_out.deliver
  end
end