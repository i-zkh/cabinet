class TransactionsController < ApplicationController
    before_filter :authorize, only: [:index, :create]

  def index 
  	@report = GetRequest.transactions(session[:vendor_id], DateTime.now.month)
  end

  def create
    @report = GetRequest.transactions(session[:vendor_id], params[:month_id])
    respond_to do |f| f.js { render "transactions/create"}
    end
  end
end
