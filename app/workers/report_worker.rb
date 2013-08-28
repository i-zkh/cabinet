#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
     def perform
	    vendor = []
	    vendor_id = Report.new(TxtPayment.new(GetRequest.report_daily)).output_report
	    if vendor_id != []
	      vendor_id.each do |v|
	        vendor = Vendor.where(id: v, distribution: true).first
	        ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	      end
	    end
	      ReportMail.accounts.deliver
    end
end
