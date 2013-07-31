class Parser
	def input
	end

	def push_data_to_db(data, vendor_id)

	address_range_last_id = AddressRange.pluck(:id).last
	user_id_range_last_id = UserIdRange.pluck(:id).last
		(0..data.size-1).each do |i|
			AddressRange.create!(city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], vendor_id: vendor_id)
    		UserIdRange.create!(user_account: data[i]["user_account"], vendor_id: vendor_id)
		end
		i = 0
		ActiveRecord::Base.connection.select_values('SELECT id FROM address_ranges WHERE id > 115152').each do |u_id|
 			Payload.create!(user_id: u_id, user_type: "AddressRange", invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
			i += 1
   		end
		i = 0
    	ActiveRecord::Base.connection.select_values('SELECT id FROM user_id_ranges WHERE id > 115152').each do |u_id|
 			Payload.create!(user_id: u_id, user_type: "UserIdRange", invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
 			i += 1
    	end
	end
end