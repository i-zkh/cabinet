class RequestPayment

	def  initialize(title, month)
		@title = title
		@month = month
	end

	def get_payment
  	response = HTTParty.get( "https://izkh.ru/api/1.0/paymenthistories",
    	:body => { :payment_history =>  { :vendor_title => @title, :month => @month }}.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["payment_history"]
	end
end