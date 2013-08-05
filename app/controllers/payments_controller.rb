class PaymentsController < ApplicationController
  def create
    request = RequestPayment.new("TITLE", "6")

    report1 = Report.new(TxtPayment.new(request.get_payment))
    report1.output_report
    p ReportMail.report("Hello").deliver
    render json: report1
  end
end