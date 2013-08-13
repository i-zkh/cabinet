class TransactionsController < ApplicationController
    before_filter :authorize, only: [:index, :create]

  def index
    vendor_id  = session[:vendor_id]
    month = DateTime.now.month
  	request = ReportMonthly.new(vendor_id, month, session_auth)
	  @report = request.get_payment_for_month
  end

  def create
    vendor_id  = session[:vendor_id]
    request = ReportMonthly.new(vendor_id, params[:month_id], session_auth)
    @report = request.get_payment_for_month
    respond_to do |f| f.js { render "transactions/create"}
    end
  end
end
