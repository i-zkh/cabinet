#encoding: utf-8
require 'russian'
class PaymentsController < ApplicationController
  def create
    #Mailer.new(GetRequest.report_daily).report
    	vendors_id, @report, @data, error = [], [], [], []
		@report = GetRequest.report_daily
	    if @report != []
	    	p @report
	      @report.each do |report|
	      	vendors_id << report['vendor_id']
	      end

	      vendors_id.uniq.each do |id|
	        case id
	        when 1..60
	          @data = @report.select { |d| d['vendor_id'] == id.to_i}
	          Report.new(TxtPayment.new(@data, id)).output_report
	          vendor = Vendor.where(id: id, distribution: true).first
	          ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	        else
	        end
	      end
	   # accountFile = File.new("error.txt", "w")
	   # accountFile.write(error)
	   # accountFile.close
	   # ReportMail.accounts.deliver
	     else
	   		ReportMail.no_transactions.deliver
	     end
    render json: true
  end
end