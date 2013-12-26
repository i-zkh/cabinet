class TransactionsController < ApplicationController
    before_filter :authorize, only: [:index, :create]

  	# Show vendor's transaction from service in cabinet.
  	def index 
  		@report = GetRequest.transactions(session[:vendor_id], DateTime.now.month)
  	end

  	def create
    	@report = GetRequest.transactions(session[:vendor_id], params[:month_id])
    	respond_to { |f| f.js { render "transactions/create" }}
  	end
end
