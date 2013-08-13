#encoding: utf-8
require 'russian'
class PaymentsController < ApplicationController
  def create
    vendor = []
      request = RequestPayment.new(session_auth)
      report = Report.new(TxtPayment.new(request.get_payment))
      vendor_id = report.output_report
      vendor_id.each do |v|
        vendor = Vendor.find(v)
        ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
      end
    render json: true
  end
end