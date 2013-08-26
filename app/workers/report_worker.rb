#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
     def perform
		vendor = []
	    report = Report.new(TxtPayment.new(GetRequest.report_daily))
	    vendor_id = report.output_report
	    vendor_id.each do |v|
	    	vendor = Vendor.find(v)
	    	ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	    end
	    	ReportMail.accounts.deliver
    end
end
