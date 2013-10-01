class EnergosbytController < ApplicationController
	def index
		enacccount = []
		EnAcccount.all.each do |e_a|
			enacccount << { user_account: e_a.user_account, city: e_a.city, street: e_a.street, building: e_a.building, apartment: e_a.apartment, bypass: e_a.bypass, meter_reading: e_a.meter_reading, invoice_amount: e_a.invoice_amount, data: e_a.data }
		end
		render json: enacccount
	end
end