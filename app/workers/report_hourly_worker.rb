#encoding: utf-8
require 'russian'
class ReportHourlyWorker
  include Sidekiq::Worker
    def perform
		@report = GetRequest.report_hourly.select { |d| d['amount'] > 5 }
	    if @report != []
			Report.new(Booker.new(@report)).output_report
			send_report_to_vendors(@report)
		else
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
		        logger.info "transaction: #{vendor.title}-#{@data}"
		   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	    	end
	    end
  	end
end
