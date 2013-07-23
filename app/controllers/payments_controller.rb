class PaymentsController < ApplicationController
  def create
    request = RequestPayment.new("TITLE", "6")

    report = Report.new(TxtPayment.new(request.get_payment))
    report.output_report

    render json: report
  end
end