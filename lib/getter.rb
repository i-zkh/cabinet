class Getter
	attr_accessor :parser

	def initialize(parser)
		@parser = parser
	end

	def input_data
		@parser.input
	end

	def self.update_accounts(data, vendor_id)
		(0..data.size-1).each do |i|
			account = Account.where(user_account: data[i]["user_account"].to_s, vendor_id: vendor_id).first
			if account
				account.invoice_amount = data[i]["invoice_amount"]
				account.save!
			else
				Account.create!(user_account: data[i]["user_account"], city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
			end
		end
	end

	def self.create_accounts(data, vendor_id)
		(0..data.size-1).each do |i|
			Account.create!(user_account: data[i]["user_account"], city: data[i]["city"], street: data[i]["street"], building: data[i]["building"], apartment: data[i]["apartment"], invoice_amount: data[i]["invoice_amount"], vendor_id: vendor_id)
		end
	end
end