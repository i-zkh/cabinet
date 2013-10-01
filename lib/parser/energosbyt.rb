#!/usr/bin/ruby -w
#encoding: UTF-8
class Energosbyt < Parser

	def initialize(file)
    	@file = file
  	end

	def input
	    s = Roo::Excel.new(@file)
		key, data = ["user_account", "city", "street", "building", "apartment", "bypass", "meter_reading", "invoice_amount", "data"], []
		hash = {}

		(2..s.last_row).each do |i|
			hash = {key[0] => s.cell(i, 1), key[1] => "Самара", key[2] => s.cell(i, 2), key[3] => s.cell(i, 3), key[4] => s.cell(i, 4), key[5] => s.cell(i, 5), key[6] => s.cell(i, 6), key[7] => s.cell(i, 7), key[8] => s.cell(i, 8)}
		  	data << hash
		end

		(0..data.size-1).each do |i|
			EnAcccount.create!(user_account: data[i]['user_account'], city: data[i]['city'], street: data[i]['street'], building: data[i]['building'], apartment: data[i]['apartment'], bypass: data[i]['bypass'], meter_reading: data[i]['meter_reading'], invoice_amount: data[i]['invoice_amount'], data: data[i]['data'])
		end
	end
end