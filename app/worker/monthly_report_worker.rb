class MonthlyReportWorker
include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform
		GetRequest.report_monthly(Date.today.month-1).each do |id|
			case id
			when 5, 40, 43, 44, 146
				filename = Report.new(ReportMonthlyTxt.new(GetRequest.transactions(id, Date.today.month-1), id)).monthly
			else
				filename = Report.new(ReportMonthly.new(GetRequest.transactions(id, Date.today.month-1), id)).monthly
			end
				vendor = Vendor.where(id: id, distribution: true).first
				ReportMessages.monthly_report(vendor.email, filename) unless vendor.nil? || vendor.id == 150
		end
    end
end