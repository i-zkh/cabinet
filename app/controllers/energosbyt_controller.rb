#encoding: UTF-8
class EnergosbytController < ApplicationController
	before_filter :authorize, only: [:xls]
	
	def index
		enacccount = []
		if params[:user_account]
			e_a = EnAcccount.where("user_account = ?", params[:user_account]).first
			e_a ? enacccount = { user_account: e_a.user_account, city: e_a.city, street: e_a.street, building: e_a.building, apartment: e_a.apartment, bypass: e_a.bypass, meter_reading: e_a.meter_reading, invoice_amount: e_a.invoice_amount, data: e_a.data } : enacccount = []
		end
		render json: enacccount
	end

	def create
		EnHandling.create!(user_account: params[:user_account], user_id: params[:user_id], remote_ip: params[:remote_ip])
	end

	# def xls
	#     p report_month_id = params[:report_month_id] 
	# 	p @handling = EnHandling.all.select { |d| d.created_at.month == report_month_id.to_i }
 #    	respond_to do |format|
 #      		format.html
 #      		format.xls
 #    	end	
	# end

	def xls
	    p report_month_id = params[:report_month_id] 
		p @handling = EnHandling.where('extract(month from created_at) = ? ', report_month_id)
    	respond_to do |format|
      		format.html
      		format.xls
    	end	
	end

	# def xls
	#     @handling = EnHandling.all
 #    	respond_to do |format|
 #      		format.html
 #      		format.xls
 #    	end	
	# end
	
	# def xls_month
	# 	p report_month_id = params[:report_month_id] ? params[:report_month_id] : DateTime.now.month
	# 	p @handling = EnHandling.all.select { |d| d.created_at.month == params[:report_month_id].to_i }
	# 	p @handling.size 
	# 	respond_to do |f| f.js { render "energosbyt/datasize"}
	# 	end
 #    	respond_to do |format|

 #      		format.html
 #      		format.xls
 #    	end	
	# end
end

