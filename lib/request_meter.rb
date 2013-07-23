class RequestMeter

	def  initialize(id, month)
		@id = id
		@month = month
	end

	def get_meter
  	response = HTTParty.get( "https://izkh.ru/api/1.0/meterreadings",
    	:body => { :meter_reading =>  { :id => @id, :month => @month }}.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["meter_reading"]
	end
end