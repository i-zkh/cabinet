class GetRequest
	class << self

	    # Report 
	    # to out@izkh.ru
	    def report_daily
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_daily?auth_token=#{Auth.get}")
	    	daily = response.parsed_response["payload"]
	    	daily.each {|d| d["user_account"].gsub!(/^00/, "")}
	    	daily
		end

		def report_from_to(from, to)
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_from_to?from=#{from}&to=#{to}&auth_token=#{Auth.get}")
	    	daily = response.parsed_response["payload"]
	    	daily.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
	    	daily
		end

		def report_daily_for_vendor
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_daily?auth_token=#{Auth.get}")
	    	daily = response.parsed_response["payload"]
	    	daily.each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: t['vendor_id']).first.commission+100)).round(2)}
	    	daily
		end

		# to managers and vendors
	    def report_hourly
		  	response = HTTParty.get( "http://izkh.ru/api/1.0/report_hourly?auth_token=#{Auth.get}")
	    	hourly = response.parsed_response["payload"]
	    	hourly.each {|d| d["user_account"].gsub!(/^00/, "")}
	    	hourly
		end

		# to vendors
		def report_monthly(month)
			response = HTTParty.get( "http://izkh.ru/api/1.0/report_vendors?auth_token=#{Auth.get}&month=#{month}")
	    	response.parsed_response
		end
		
		# Transactions for month in cabinet
		def transactions(vendor_id, month)
	  		response = HTTParty.get( "http://izkh.ru/api/1.0/report_monthly?vendor_id=#{vendor_id}&month=#{month}&auth_token=#{Auth.get}")
	    	response.parsed_response["payment_history"].each {|t| t["amount"] = (t["amount"]*100/(Vendor.where(id: vendor_id).first.commission+100)).round(2)}
			response.parsed_response["payment_history"]
		end

		# Meters for month in cabinet
		def utility_metrics(vendor_id, from, to)
	  		response = HTTParty.get( "http://izkh.ru/utility_metrics/report?vendor_id=#{vendor_id}&from=#{from}&to=#{to}&auth_token=#{Auth.get}")
		    response.parsed_response
		end

		def meters(vendor_id, month)
	  		response = HTTParty.get( "http://izkh.ru/api/1.0/meterreadings",
	    		:body => { :meter_reading =>  { :vendor_id => vendor_id, :month => month }}.to_json,
	    		:headers => { 'Content-Type' => 'application/json' })
		    response.parsed_response["meter_reading"]
		end
		
		# Vendor's handbook
	    # Geocode from yandex for
		def geocode(address)
	    	response = HTTParty.get( URI::encode("http://geocode-maps.yandex.ru/1.x/?geocode=#{address}&format=json") )
	        response["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"].gsub!(" ", ",")
		end

		# List of handbook's categories
		def nonutilityservicetype
			response = HTTParty.get( "http://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def non_utility_vendors
			response = HTTParty.get( "http://izkh.ru/api/1.0/non_utility_vendors?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		# Add vendors to service
		# List of vendor's categories
		def servicetypes
			response = HTTParty.get( "http://izkh.ru/api/1.0/servicetypes?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

	    # List of cities in service
		def cities
			response = HTTParty.get( "http://izkh.ru/api/1.0/cities?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		# Vendor's ids for update users amount in service
		def user_accounts(vendor_id)
			response = HTTParty.get( "http://izkh.ru/api/1.0/user_accounts/#{vendor_id}?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		# notification user abount amount
		def users_data(vendor_id)
			response = HTTParty.get( "http://izkh.ru/api/1.0/users_data/#{vendor_id}?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		# Catehories for update freelances 
		def freelancecategories
			response = HTTParty.get( "http://izkh.ru/api/1.0/freelancecategory?auth_token=#{Auth.get}") 
	    	response.parsed_response
		end

		def vendors
			response = HTTParty.get( "http://izkh.ru/api/1.0/vendors?auth_token=#{Auth.get}")
	    	response.parsed_response
	    end
	end
end