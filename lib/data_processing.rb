class DataProcessing 

	def self.amount_to_service(data, vendor_id)
		response, array, @data = [], [], []
		hash = {}
		response = GetRequest.vendor_id(vendor_id)
		response.each do |r|
			@data = data.select { |d| d['user_account'] == r }
			@data.each do |d|
				if (d['invoice_amount'].to_f >= 0)
					amount = 0
				else
					amount = d['invoice_amount'].to_f*(-1)
				end
					hash = { vendor_id: vendor_id, user_account: d['user_account'], amount: amount} 
					array << hash
			end
		end
		  PostRequest.payload(array)
	end

	def self.amount_from_db(vendor_id)
		response, array, @data, error = [], [], [], []
		hash = {}
		response = GetRequest.vendor_id(vendor_id)
		response.each do |r|
			account = Account.where(user_account: r, vendor_id: vendor_id).first
			if account
				if account.invoice_amount.to_f < 0
					amount = account.invoice_amount.to_f*(-1)
					hash = { vendor_id: vendor_id, user_account: account.user_account, amount: amount}
					array << hash
				end
			else
				hash = { vendor_id: vendor_id, user_account: r }
				error << hash
			end
		end
		ReportMail.error(error).deliver if error != []
		PostRequest.payload(array)
	end

	def self.push_data_to_db(data, vendor_id)
	#p address_range_last_id = AddressRange.last.id
	#p user_id_range_last_id = UserIdRange.last.id
	#  	(0..data.size-1).each do |i|
	#  		AddressRange.create!(city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], vendor_id: vendor_id)
 #     		UserIdRange.create!(user_account: data[i]["user_account"], vendor_id: vendor_id)
	#  	end
	#  	i = 0
	#  	ActiveRecord::Base.connection.select_values('SELECT id FROM address_ranges WHERE id > 213845').each do |u_id|
 #  			Payload.create!(user_id: u_id, user_type: "AddressRange", invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
	#  		i += 1
 #   		end
	# 	i = 0
 #    	ActiveRecord::Base.connection.select_values('SELECT id FROM user_id_ranges WHERE id > 234989').each do |u_id|
 # 			Payload.create!(user_id: u_id, user_type: "UserIdRange", invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
 # 			i += 1
 #    	end
	end

	def self.update_accounts(data, vendor_id)
		(0..data.size-1).each do |i|
			account = Account.where(user_account: data[i]["user_account"].to_s, vendor_id: vendor_id).first
			if account
				account.invoice_amount = data[i]["invoice_amount"]
				account.save!
			else
				p Account.create!(user_account: data[i]["user_account"], city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
			end
		end
	end

	def self.push_data_to_account(data, vendor_id)
		(0..data.size-1).each do |i|
			Account.create!(user_account: data[i]["user_account"], city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
		end
	end
end