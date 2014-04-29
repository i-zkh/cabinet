#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
  	# Daily report and errors to out@izkh.ru
    def perform
      @report = GetRequest.report_daily
      if @report != []
        # send_report_to_vendors(GetRequest.report_daily_for_vendor)
        # Report.new(AllPayment.new(@report)).output_report
        # Report.new(Error.new(@report)).output_report
      else
        # ReportMail.no_transactions.deliver
        # logger.info "no transactions"
      end

      @terminal = GetRequest.report_terminal
      if @terminal != []
        # send_report_to_vendors(GetRequest.report_terminal_for_vendor)
        # Report.new(AllPayment.new(@report)).output_report
        # Report.new(Error.new(@report)).output_report
      else
        # ReportMail.no_transactions.deliver
        # logger.info "terminals: no transactions"
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
end
