class RequestPayment
	def  initialize(auth)
		@auth = auth
	end

	def get_payment
  	response = HTTParty.get( "https://izkh.ru/api/1.0/report_daily?auth_token=#{@auth}")
    return response.parsed_response["payload"]
	end
end