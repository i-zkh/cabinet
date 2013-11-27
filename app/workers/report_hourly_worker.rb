#encoding: utf-8
require 'russian'
class ReportHourlyWorker
  include Sidekiq::Worker
    def perform
    	vendors_id, @report, @data = [], [], []
		@report = GetRequest.report_hourly
	    if @report != []
			Report.new(Booker.new(@report)).output_report
			Report.new(Error.new(@report)).output_report

	    	@report.each { |report| vendors_id << report['vendor_id'] }

	      	vendors_id.uniq.each do |id|
	      		@data = @report.select { |d| d['vendor_id'] == id.to_i }
	      		vendor = Vendor.where(id: id, distribution: true).first
	      		if vendor
			        case id
			    	when 5, 44, 40
			          	Report.new(TxtCheckAddress.new(@data, id)).output_report
			        else
			          	Report.new(TxtPayment.new(@data, id)).output_report
			        end
			        logger.info "transaction for #{vendor.title}"
			   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	   			end
	      	end
	    else
	      	logger.info "No transactions"
	    end
    end
end