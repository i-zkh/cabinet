#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
  	# Daily report and errors to out@izkh.ru
    def perform
		@report = GetRequest.report_daily
	    if @report != []
	    	send_report_to_vendors(@report)
			Report.new(AllPayment.new(@report)).output_report
			Report.new(Error.new(@report)).output_report
	    else
	   		ReportMail.no_transactions.deliver
	   		logger.info "no transactions"
	    end
    end

    private

  	def send_report_to_vendors(report)
  		vendors_id = []
	    report.each { |r| vendors_id << r['vendor_id'] }
	    vendors_id.uniq.each do |id|
	      	@data = report.select { |d| d['vendor_id'] == id.to_i }
	      	vendor = Vendor.where(id: id, distribution: true).first
	      	if vendor
		        case id
		    	when 5, 44, 40
		          	Report.new(TxtCheckAddress.new(@data, id)).output_report
		        else
		          	Report.new(TxtPayment.new(@data, id)).output_report
		        end
		   		ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
		   		logger.info "transaction: #{vendor.title}-#{@data}"
	    	end
	    end
  	end
end
