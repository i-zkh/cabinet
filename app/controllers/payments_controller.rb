#encoding: utf-8
class PaymentsController < ApplicationController

	# Daily report for managers
	def xls_report_daily
		@report = GetRequest.report_daily
	end

	def xls
		Report.new(ReportForManager.new(GetRequest.report_daily)).output_report
		send_file 'transactions.xls'
	end

  	# Daily report and errors to out@izkh.ru
    def create
		@report = GetRequest.report_from_to("2014-03-25", "2014-03-24")
	    if @report != []
	    	# send_report_to_vendors(@report)
			# Report.new(AllPayment.new(@report)).output_report
			# Report.new(Error.new(@report)).output_report
	    else
	   		ReportMail.no_transactions.deliver
	    end
	    render json: @report
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
		          	filename = Report.new(TxtCheckAddress.new(@data, id)).output_report
		        when 150
		        	filename = Report.new(Factorial.new(@data, id)).output_report
		        else
		          	filename = Report.new(TxtPayment.new(@data, id)).output_report
		        end
		   		ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}")
	    	end
	    end
  	end
end