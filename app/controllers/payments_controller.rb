#encoding: utf-8
class PaymentsController < ApplicationController

	# Daily report for managers
	def xls_report_daily
		@transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
		@report = GetRequest.report_daily
		@terminal = GetRequest.terminal((Date.today-1).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d"))
	end

	def xls
		Report.new(ReportForManager.new(GetRequest.report_daily)).output_report
		send_file 'transactions.xls'
	end

  	# Daily report and errors to out@izkh.ru
  #   def create
		# @report = GetRequest.report_from_to("2014-04-15", "2014-04-16")
	 #    if @report != []
	 #    	send_report_to_vendors(GetRequest.report_from_to("2014-04-15", "2014-04-16"))
		# 		# Report.new(AllPayment.new(@report)).output_report
		# 		# Report.new(Error.new(@report)).output_report
	 #   #  else
	 #   # 		ReportMail.no_transactions.deliver
	 #    end
	 #    render json: @report
  #   end

    def create
		@report = GetRequest.report_daily
	    if @report != []
	    	send_report_to_vendors(GetRequest.report_daily_for_vendor)
				Report.new(AllPayment.new(@report)).output_report
				Report.new(Error.new(@report)).output_report
	    else
	   		ReportMail.no_transactions.deliver
	   		logger.info "no transactions"
	    end
	  
	  logger.info @terminal = GetRequest.report_terminal
	  	if @terminal != []
	    	send_report_to_vendors(GetRequest.report_terminal_for_vendor)
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
		          	filename = Report.new(TxtCheckAddress.new(@data, id)).output_report
		        when 150
		        	filename = Report.new(Factorial.new(@data, id)).output_report
		        else
		          	filename = Report.new(TxtPayment.new(@data, id)).output_report
		        end
		   		ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}")
	    		logger.info "transaction: #{vendor.title}-#{@data}"
	    	end
	    end
  	end

    def report_monthly
    	GetRequest.report_monthly(Date.today.month-2).each do |id|
			case id
			when 5, 40, 43, 44, 146
				filename = Report.new(ReportMonthlyTxt.new(GetRequest.transactions(id, Date.today.month-2), id)).monthly
			else
				filename = Report.new(ReportMonthly.new(GetRequest.transactions(id, Date.today.month-2), id)).monthly
			end
				vendor = Vendor.where(id: id, distribution: true).first
				# ReportMessages.monthly_report(vendor.email, filename) unless vendor.nil? || vendor.id == 150
			end
			render json: true
    end

  	private

	# def send_report_to_vendors(report)
 #  		vendors_id = []
	#     report.each { |r| vendors_id << r['vendor_id'] }
	#     vendors_id.uniq.each do |id|
	#       	p @data = report.select { |d| d['vendor_id'] == id.to_i }
	#       	p vendor = Vendor.where(id: id, distribution: true).first
	#       	if vendor
	# 	        case id
	# 	    		when 5, 44, 40
	# 	          	filename = Report.new(TxtCheckAddress.new(@data, id)).output_report
	# 	        when 150
	# 	        	p "--------"
	# 	        	filename = Report.new(Factorial.new(@data, id)).output_report
	# 	        else
	# 	          	filename = Report.new(TxtPayment.new(@data, id)).output_report
	# 	        end
	# 	        p filename
	# 	   		# ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}")
	#     	end
	#     end
 #  	end
end