#encoding: utf-8
require 'russian'
class ReportHourlyWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform
		@report = GetRequest.report_hourly.select { |d| d['amount'] > 3 && d['vendor_id'] ==  143 }
	    if @report != []
			# Report.new(Booker.new(@report)).output_report
			logger.info "transaction: #{@report}"
		else
	   		logger.info "no transactions"
    	end
    end
end
