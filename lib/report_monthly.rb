class ReportMonthly
	def  initialize(vendor_id, month, auth)
		@vendor_id = vendor_id
		@month = month
		@auth = auth
	end

	def get_payment_for_month
  	response = HTTParty.get( "https://izkh.ru/api/1.0/report_monthly?vendor_id=#{@vendor_id}&month=#{@month}&auth_token=#{@auth}")
    return response.parsed_response["payment_history"]
	end
end