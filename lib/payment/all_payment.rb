class AllPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    reportFile = File.new("report.txt", "w")
    @data.each {|d| reportFile.puts("#{d}")}
    reportFile.close
    # ReportMail.report_to_out.deliver
  end
end