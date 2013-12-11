#encoding: utf-8
class PaymentsController < ApplicationController

  	def create
    	vendors_id, @report, @data, error = [], [], [], []
		@report = GetRequest.report_daily
		@report = @report.select { |d|  d['amount'] > 5 }
	    if @report != []
			Report.new(AllPayment.new(@report)).output_report
			# Report.new(Booker.new(@report)).output_report
			Report.new(Error.new(@report)).output_report

	      @report.each do |report|
	      	vendors_id << report['vendor_id']
	      end
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
		   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	   		end
	      end
	    else
	   		ReportMail.no_transactions.deliver
	    end
    	render json: @report
  	end

	def monthly_xls
		vendors_id = GetRequest.report_monthly(DateTime.now.month)
		vendors_id.each do |id|
			vendor = Vendor.where(id: id, distribution: true).first
			unless vendor.nil?
				p id
				# p @report = GetRequest.report_monthly(id, DateTime.now.month)
				# Report.new(ReportMonthly.new(@report, id)).monthly
				ReportMail.report_monthly("Выгрузка транзакций АйЖКХ за ноябрь}", vendor).deliver if id != 5 || id != 45
			end
		end
		render json: true
	end

  	def monthly_txt
	 	p @report = GetRequest.transactions(16, 11)
	    Report.new(ReportMonthlyTxt.new(@report, 16)).monthly

	    render json: true
  	end

  	def hourly
		@report = []
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
		   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	   		end
	    end
  	end

end