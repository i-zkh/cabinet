#!/usr/bin/ruby -w
#encoding: UTF-8
class EnergosbytController < ApplicationController
	def index
		enacccount = []
		if params[:user_account]
			e_a = EnAcccount.where(user_account: params[:user_account]).first
			enacccount = { user_account: e_a.user_account, city: e_a.city, street: e_a.street, building: e_a.building, apartment: e_a.apartment, bypass: e_a.bypass, meter_reading: e_a.meter_reading, invoice_amount: e_a.invoice_amount, data: e_a.data }
		else
			EnAcccount.all.each do |e_a|
				enacccount << { user_account: e_a.user_account, city: e_a.city, street: e_a.street, building: e_a.building, apartment: e_a.apartment, bypass: e_a.bypass, meter_reading: e_a.meter_reading, invoice_amount: e_a.invoice_amount, data: e_a.data }
			end
		end
		render json: enacccount
	end
end