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
				if account.invoice_amount.to_f != 0
					amount = account.invoice_amount.to_f*(-1)
					hash = { vendor_id: vendor_id, user_account: account.user_account, amount: amount}
					array << hash
				end
			else
				hash = { vendor_id: vendor_id, user_account: r }
				error << hash
			end
		end
		ReportMail.error(error, "[ERROR] user accounts").deliver unless error.empty?
		PostRequest.payload(array) unless array == []
	end

end