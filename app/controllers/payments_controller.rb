#encoding: utf-8
class PaymentsController < ApplicationController
  layout 'manager'
  before_filter :authorize, only: [:index, :create, :xls]

	# Daily report for managers
	def index
	 	@payments = GetRequest.report_from_to(Date.today-1, Date.today)
    @transactions_type = transactions_type
  end

  def create
    @from = params[:from] != "" ? params[:from] : Date.today.beginning_of_month
    @to = params[:to] != "" ? params[:to] : Date.today.end_of_month
    @transactions_type = transactions_type
    @payments = GetRequest.report_from_to(@from, @to)
  end

	def xls
    @from = params[:from].nil? ? Date.today-1 : params[:from] 
    @to = params[:to].nil? ? Date.today : params[:to]
   	@report = GetRequest.report_from_to(@from, @to)
		Report.new(ReportForManager.new(@report, transactions_type)).output_report
		send_file 'transactions.xls'
	end

  def report_monthly
    @payments = GetRequest.report_monthly(5)
    render json: @payments
  end

  def report_from_to
    @payments = GetRequest.index_with_vendor_id(params[:from], params[:to])
    send_report_to_vendors(@payments)
    # Report.new(AllPayment.new(@payments)).output_report
    render json: @payments
  end

  private

  def transactions_type
    ['', 'PayOnline', 'Yandex Деньги', 'Yandex Карты', 'Cash in', 'Терминал', 'WebMoney', 'Сбербанк Онлайн']
  end

  def send_report_to_vendors(report)
    vendors_id = []
    report.each{|r| vendors_id << r.split(';')[-1]}
    vendors_id.uniq.each do |id|
      vendor = Vendor.where(id: id.to_i, distribution: true).first
      if vendor
        @data = report.select{|d| d.split(';')[-1] == id}
        case id.to_i
        when 5, 44, 40, 146, 16
          filename = Report.new(TxtCheckAddress.new(@data, id)).output_report
        when 150
          filename = Report.new(Factorial.new(@data, id)).output_report
        when 20
          # filenames = Report.new(Delta.new(@data, id)).output_report
          # filenames.each { |f| ReportMail.report(vendor, f).deliver }
        else
          filename = Report.new(TxtPayment.new(@data, id)).output_report
        end
        # ReportMail.report(vendor, filename).deliver unless File.zero?("#{filename}") || vendor.id == 16
        logger.info "transaction: #{vendor.title}-#{@data}"
      end
    end
  end
end