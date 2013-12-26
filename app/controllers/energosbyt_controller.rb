#encoding: UTF-8
class EnergosbytController < ApplicationController
	before_filter :authorize, only: [:xls]
	# Only for "Энегросбыт".
	# Show in service meter readings.
	def index
		enacccount = []
		if params[:user_account]
			e_a = EnAcccount.where("user_account = ?", params[:user_account]).first
			e_a ? enacccount = { user_account: e_a.user_account, city: e_a.city, street: e_a.street, building: e_a.building, apartment: e_a.apartment, bypass: e_a.bypass, meter_reading: e_a.meter_reading, invoice_amount: e_a.invoice_amount, data: e_a.data } : enacccount = []
		end
		render json: enacccount
	end

	# Create user's handling to service. 
	# attr: user_account, user_id, remote_ip.
	def create
		EnHandling.create!(user_account: params[:user_account], user_id: params[:user_id], remote_ip: params[:remote_ip])
		render json: {}
	end

	# Vendor can get handlings in xls.
	def xls
		@month = params[:report_month_id] ? params[:report_month_id] : DateTime.now.month
		@handling = EnHandling.where('extract(month from created_at) = ? ', @month )
    	respond_to do |format|
      		format.html
      		format.xls
    	end	
	end
end

