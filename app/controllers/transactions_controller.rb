class TransactionsController < ApplicationController
  def index
  	request = RequestPayment.new("TITLE", DateTime.now.month)
	  @report = request.get_payment
  end

  def create
    request = RequestPayment.new("TITLE", params[:month_id])
    @report = request.get_payment
    respond_to do |f| f.js { render "transactions/create"}
    end
  end
end
