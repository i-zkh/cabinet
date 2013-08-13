#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
     def perform
		vendor = []
 		auth = "LuNXcS4tAGMgj8xwr7LR"
	    request = RequestPayment.new(auth)
	    report = Report.new(TxtPayment.new(request.get_payment))
	    vendor_id = report.output_report
	    vendor_id.each do |v|
	    	vendor = Vendor.find(v)
	    	ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	    end
    end
end
