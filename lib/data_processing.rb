class DataProcessing 

	def self.amount_to_service(vendor_id)
		user_amounts = []
		GetRequest.user_accounts(vendor_id).each do |u_a|
			account = Account.where('vendor_id = ? AND user_account = ?', vendor_id, u_a).first
			user_amounts << { vendor_id: vendor_id, user_account: account.user_account, amount: account.invoice_amount.to_f >= 0 ? 0 : account.invoice_amount.to_f*(-1) } if account
		end
		# PostRequest.payload(user_amounts)
	end

    def self.user_notifications(vendor_id)
        paid_accounts, users_data = [], []
        GetRequest.report_daily.each {|r| paid_accounts << r['user_account'] if r['vendor_id'] == vendor_id }
        GetRequest.users_data(vendor_id).each do |u_d| 
            amount = Account.where('vendor_id = ? AND user_account = ?', vendor_id, u_d['user_account']).first
            if !paid_accounts.include?(u_d["user_account"]) && amount
                amount = amount.invoice_amount.to_f <= 0 ? 0 : amount.invoice_amount.to_f*(-1)
                users_data << { "user_name" => u_d['user_name'], "user_email" => u_d['user_email'], "amount" => amount } if amount != 0
            end
        end
        users_data.each {|u_d| ReportMessages.send_user_amount(u_d['user_name'], u_d['user_email'], u_d['amount'])}
    end
end