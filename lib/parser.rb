class Parser
	
	def input
		CheckParsers.check(@data)
		@data
	end

	def self.create(data, vendor_id)
		case vendor_id
		when 107
			EnAcccount.destroy_all
			(0..data.size-1).each {|i| EnAcccount.create!(user_account: data[i]['user_account'], city: data[i]['city'], street: data[i]['street'], building: data[i]['building'], apartment: data[i]['apartment'], bypass: data[i]['bypass'], meter_reading: data[i]['meter_reading'], invoice_amount: data[i]['invoice_amount'], data: data[i]['data'])}
		else
			Account.destroy_all(vendor_id: vendor_id)
			(0..data.size-1).each { |i| Account.create!(user_account: data[i]["user_account"], city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id) }
		end
	end
end