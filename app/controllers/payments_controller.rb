#encoding: utf-8
class PaymentsController < ApplicationController

	# Daily report for managers
	def xls_report_daily
		@transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
		@report = GetRequest.report_daily
		@terminal = GetRequest.terminal((Date.today-1).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d"))
	end

	def index
	 	@payments = GetRequest.report_from_to(Date.today-1, Date.today)
  end

  def create
    @from = params[:from] != "" ? params[:from] : Date.today.beginning_of_month
    @to = params[:to] != "" ? params[:to] : Date.today.end_of_month
    @payments = GetRequest.report_from_to(@from, @to)
  end

	def xls
    @from = params[:from].nil? ? Date.today-1 : params[:from] 
    @to = params[:to].nil? ? Date.today : params[:to]
   	@report = GetRequest.report_from_to(@from, @to)
		Report.new(ReportForManager.new(@report)).output_report
		send_file 'transactions.xls'
	end

  def report_monthly
    @payments = GetRequest.report_monthly(5)
    render json: @payments
  end

  def old_report_monthly
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

  def report_from_to
    @payments = GetRequest.index_with_vendor_id(params[:from], params[:to])
    send_report_to_vendors(@payments)
    # Report.new(AllPayment.new(@payments)).output_report
    render json: @payments
  end

  private

	def send_report_to_vendors(report)
  	vendors_id = []
	  report.each{|r| vendors_id << r.split(';')[8]}
	  vendors_id.uniq.each do |id|
      vendor = Vendor.where(id: id.to_i, distribution: true).first
			if vendor
        @data = report.select{|d| d.split(';')[8]  == id}
		   	case id.to_i
		   	when 5, 44, 40, 146, 16
		        filename = Report.new(TxtCheckAddress.new(@data, id)).output_report
		    when 150
		      	filename = Report.new(Factorial.new(@data, id)).output_report
        when 20
            filename = Report.new(Delta.new(@data, id)).output_report
		    else
		        filename = Report.new(TxtPayment.new(@data, id)).output_report
		    end
		  	# ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}") && vendor.id == 16
	   		logger.info "transaction: #{vendor.title}-#{@data}"
	   	end
	  end
  end

end