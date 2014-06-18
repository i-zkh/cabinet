#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
  
  # Daily report and errors to out@izkh.ru
  def perform
    @payments = GetRequest.index_with_vendor_id((Date.today-1).strftime("%Y-%m-%d"), Date.today.strftime("%Y-%m-%d"))
    send_report_to_vendors(@payments)
    # Report.new(AllPayment.new(@payments)).output_report
  end

  private

  def send_report_to_vendors(report)
    vendors_id = []
    report.each{|r| vendors_id << r.split(';')[8]}
    vendors_id.uniq.each do |id|
      vendor = Vendor.where(id: id.to_i, distribution: true).first
      if vendor
        @data = report.select{|d| d.split(';')[8] == id}
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
        ReportMail.report(vendor, filename).deliver if vendor.id == 20
        logger.info "transaction: #{vendor.title}-#{@data}"
      end
    end
  end
end
