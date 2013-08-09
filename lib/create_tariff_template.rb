class CreateTariffTemplate

	def  initialize(title, vendor_id,  service_type_id, has_readings, auth)
		@title = title
		@vendor_id = vendor_id
		@has_readings = has_readings
		@service_type_id = service_type_id
		@auth = auth
	end

	def request
  	response = HTTParty.post( "https://izkh.ru/api/1.0/tariff_template",
    	:body => { :tariff_template =>  { :title => @title, :vendor_id => @vendor_id, :has_readings => @has_readings, :service_type_id => @service_type_id },
    	:auth_token => @auth}.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["tariff_template"]
	end
end