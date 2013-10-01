class GetRequest
	def self.vendors
		response = HTTParty.get( "https://izkh.ru/api/1.0/vendors?auth_token=#{Auth.get}")
    	response.parsed_response
    end

    def self.report_daily
	  	response = HTTParty.get( "https://izkh.ru/api/1.0/report_daily?auth_token=#{Auth.get}")
    	response.parsed_response["payload"]
	end

	def self.report_monthly(vendor_id, month)
  		response = HTTParty.get( "https://izkh.ru/api/1.0/report_monthly?vendor_id=#{vendor_id}&month=#{month}&auth_token=#{Auth.get}")
    	response.parsed_response["payment_history"]
	end

	def self.meters(vendor_id, month)
  		response = HTTParty.get( "https://izkh.ru/api/1.0/meterreadings",
    		:body => { :meter_reading =>  { :vendor_id => vendor_id, :month => month }}.to_json,
    		:headers => { 'Content-Type' => 'application/json' })
	    response.parsed_response["meter_reading"]
	end

	def self.nonutilityservicetype
		response = HTTParty.get( "https://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}") 
    	response.parsed_response
	end

	def self.servicetypes
		response = HTTParty.get( "https://izkh.ru/api/1.0/servicetypes?auth_token=#{Auth.get}") 
    	response.parsed_response
	end

	def self.geocode(address)
    	response = HTTParty.get( URI::encode("http://geocode-maps.yandex.ru/1.x/?geocode=#{address}&format=json") )
        response["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"].gsub!(" ", ",")
	end

	def self.vendor_id(vendor_id)
		response = HTTParty.get( "https://izkh.ru/api/1.0/user_accounts/#{vendor_id}?auth_token=#{Auth.get}") 
    	response.parsed_response
	end

	def self.freelancecategories
		response = HTTParty.get( "https://izkh.ru/api/1.0/freelancecategory?auth_token=#{Auth.get}") 
    	response.parsed_response
	end
end