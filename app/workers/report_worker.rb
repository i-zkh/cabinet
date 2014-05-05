#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
  # Daily report and errors to out@izkh.ru
  def perform
    @report = GetRequest.report_from_to(Date.today-1, Date.today)
    @online_payments = @report["payload"]
    @terminal_payments = @report["terminal"]
    @online_payments_for_vendors = @online_payments.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
    @terminal_payments_for_vendors = @terminal_payments.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
    
    send_report_to_vendors(@online_payments_for_vendors)
    send_report_to_vendors(@terminal_payments_for_vendors)
    # Report.new(AllPayment.new(@online_payments)).output_report
    # Report.new(AllPayment.new(@terminal_payments)).output_report
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
