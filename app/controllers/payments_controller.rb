#encoding: utf-8
require 'russian'
class PaymentsController < ApplicationController
  def create
    	vendors_id, @report, @data, error = [], [], [], []
		@report = GetRequest.report_daily
	    if @report != []
			Report.new(AllPayment.new(@report)).output_report 
			Report.new(Booker.new(@report)).output_report
			Report.new(Error.new(@report)).output_report

	      @report.each do |report|
	      	vendors_id << report['vendor_id']
	      end
	      vendors_id.uniq.each do |id|
	      	@data = @report.select { |d| d['vendor_id'] == id.to_i}
	      	vendor = Vendor.where(id: id, distribution: true).first
	        case id
	    	  when 5
	          	Report.new(TxtCheckAddress.new(@data, id)).output_report
	          else
	          	Report.new(TxtPayment.new(@data, id)).output_report
	        end
	   		ReportMail.report_to_vendors("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver  	
	      end
	    else
	   		ReportMail.no_transactions.deliver
	    end
    render json: @report
  end
end