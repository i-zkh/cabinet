#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker

    def perform
		@report = []
		@report = GetRequest.report_daily
	    if @report != []
			Report.new(AllPayment.new(@report)).output_report
			Report.new(Error.new(@report)).output_report
	    else
	   		ReportMail.no_transactions.deliver
	    end
    end
end
