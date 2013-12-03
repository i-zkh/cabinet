class GetRequest
	class << self

		def vendors
			response = HTTParty.get( "http://izkh.ru/api/1.0/vendors?auth_token=#{Auth.get}")
	    	response.parsed_response
	    end

	    def report_daily
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_daily?auth_token=#{Auth.get}")
	    	daily = response.parsed_response["payload"]
	    	daily.each {|d| d["user_account"].gsub!(/^00/, "")}
	    	daily
		end

	    def report_hourly
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_hourly?auth_token=#{Auth.get}")
	    	daily = response.parsed_response["payload"]
	    	daily.each {|d| d["user_account"].gsub!(/^00/, "")}
	    	daily
		end
		
		def report_monthly(vendor_id, month)
	  		response = HTTParty.get( "http://izkh.ru/api/1.0/report_monthly?vendor_id=#{vendor_id}&month=#{month}&auth_token=#{Auth.get}")
	    	response.parsed_response["payment_history"] #.each {|m| m["user_account"].gsub!(/^00/, "")}
		end

		def meters(vendor_id, month)
	  		response = HTTParty.get( "http://izkh.ru/api/1.0/meterreadings",
	    		:body => { :meter_reading =>  { :vendor_id => vendor_id, :month => month }}.to_json,
	    		:headers => { 'Content-Type' => 'application/json' })
		    response.parsed_response["meter_reading"]
		end

		def nonutilityservicetype
			response = HTTParty.get( "http://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def servicetypes
			response = HTTParty.get( "http://izkh.ru/api/1.0/servicetypes?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def geocode(address)
	    	response = HTTParty.get( URI::encode("http://geocode-maps.yandex.ru/1.x/?geocode=#{address}&format=json") )
	        response["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"].gsub!(" ", ",")
		end

		def vendor_id(vendor_id)
			response = HTTParty.get( "http://izkh.ru/api/1.0/user_accounts/#{vendor_id}?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def freelancecategories
			response = HTTParty.get( "http://izkh.ru/api/1.0/freelancecategory?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def cities
			response = HTTParty.get( "http://izkh.ru/api/1.0/cities?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def report_vendors(month)
			response = HTTParty.get( "http://izkh.ru/api/1.0/report_vendors?auth_token=#{Auth.get}&month=#{month}")
	    	response.parsed_response
		end

	end
end