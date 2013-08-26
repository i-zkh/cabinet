#encoding: utf-8
require 'russian'
class PaymentsController < ApplicationController
  def create
    vendor = []
    vendor_id = Report.new(TxtPayment.new(GetRequest.report_daily)).output_report
    vendor_id.each do |v|
      vendor = Vendor.find(v)
      ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
    end
      ReportMail.accounts.deliver
    render json: true
  end
end