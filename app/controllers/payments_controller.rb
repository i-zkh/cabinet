#encoding: utf-8
class PaymentsController < ApplicationController

  	# Daily report and errors to out@izkh.ru
    def create
		@report = GetRequest.report_daily
	    if @report != []
			Report.new(AllPayment.new(@report)).output_report
			Report.new(Error.new(@report)).output_report
			Report.new(Booker.new(@report)).output_report
			send_report_to_vendors(@report)
	    else
	   		ReportMail.no_transactions.deliver
	   		logger.info "no transactions"
	    end
	    render json: @report
    end

	def monthly_xls
		GetRequest.report_monthly(12).each do |id|
			Report.new(ReportMonthly.new(GetRequest.transactions(id, 12), id)).monthly
			vendor = Vendor.where(id: id, distribution: true).first
			# ReportMail.report_monthly("Выгрузка транзакций АйЖКХ за ноябрь}", vendor).deliver if id != 5 || id != 40 || id != 41 && !vendor.nil?
		end	
		render json: true
	end

  	def monthly_txt
		# GetRequest.report_monthly(11).each do |id|
			vendor = Vendor.where(id: 121).first
			unless vendor.nil?
	 			p @report = GetRequest.transactions(121, 1)
	    		p Report.new(ReportMonthlyTxt.new(@report, 121)).monthly
			end
		# end

	    render json: true
  	end

  	def hourly
		@report = GetRequest.report_hourly
	    if @report != []
			Report.new(Booker.new(@report)).output_report
			# send_report_to_vendors(@report)
    	end
    	render json: true
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