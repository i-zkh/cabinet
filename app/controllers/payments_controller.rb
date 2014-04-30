#encoding: utf-8
class PaymentsController < ApplicationController

	# Daily report for managers
	def xls_report_daily
		@transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
		@report = GetRequest.report_daily
		@terminal = GetRequest.terminal((Date.today-1).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d"))
	end

	def index
	 	@report = GetRequest.report_from_to(Date.today-1, Date.today)
		@transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
		@payments = @report["payload"]
		@terminal = @report["terminal"]
  end

  def create
  	array = []
    @from = params[:from] != "" ? params[:from] : Date.today.beginning_of_month
    @to = params[:to] != "" ? params[:to] : Date.today.end_of_month
    @report = GetRequest.report_from_to(@from, @to)
    @transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
  	@payments = @report["payload"]
  	@terminal = @report["terminal"]
  end

	def xls
    @transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
   	@report = GetRequest.report_from_to(Date.today-1, Date.today)
		Report.new(ReportForManager.new(@report["payload"])).output_report
		send_file 'transactions.xls'
	end

  def report_from_to
  	@report = GetRequest.report_from_to(params[:from], params[:to])
  	@online_payments = @report["payload"]
  	@terminal_payments = @report["terminal"]
  	@online_payments_for_vendors = @online_payments.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
  	@terminal_payments_for_vendors = @terminal_payments.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
	  
	  # send_report_to_vendors(@online_payments_for_vendors)
	  # send_report_to_vendors(@terminal_payments_for_vendors)
		# Report.new(AllPayment.new(@online_payments)).output_report
		# Report.new(AllPayment.new(@terminal_payments)).output_report
		render json: @report
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
		  	# ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}")
	   		logger.info "transaction: #{vendor.title}-#{@data}"
	   	end
	  end
  end

end