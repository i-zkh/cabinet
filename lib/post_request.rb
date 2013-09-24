require 'open-uri'
class PostRequest
	def self.non_utility_service_type(title)
	  	response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}",
	    	:body => { :non_utility_service_type => { title: title }}.to_json,
	    	:headers => {'Content-Type' => 'application/json'})
	end

	def self.non_utility_vendor(title, phone, work_time, address, non_utility_service_type_id, geocode)
		response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
            :picture => { url: "http://static-maps.yandex.ru/1.x/?ll=#{geocode}&z=15&l=map&size=300,200&pt=#{geocode}" }}.to_json,
            :headers => {'Content-Type' => 'application/json'})
	end

	def self.vendor(title, service_type_id)
		response = HTTParty.post( "https://izkh.ru/api/1.0/vendor?auth_token=#{Auth.get}",
	    	:body => { :vendor =>  { title: title, service_type_id: service_type_id, is_active: true }}.to_json,
	    	:headers => {'Content-Type' => 'application/json'})
	end

	def self.field_template(title, value, is_for_calc, tariff_template_id, field_type, field_units)
		response = HTTParty.post( "https://izkh.ru/api/1.0/field_template?auth_token=#{Auth.get}",
    		:body => { :field_template => { title: title, value: value, is_for_calc: is_for_calc, tariff_template_id: tariff_template_id, field_type: field_type, field_units: field_units}}.to_json,
    		:headers => {'Content-Type' => 'application/json'})
	end

	def self.tariff_template(title, vendor_id, has_readings, service_type_id)
		response = HTTParty.post( "https://izkh.ru/api/1.0/tariff_template?auth_token=#{Auth.get}",
    		:body => { :tariff_template => { title: title, vendor_id: vendor_id, has_readings: has_readings, service_type_id: service_type_id }}.to_json,
    		:headers => {'Content-Type' => 'application/json'})
	end

	def self.non_utility_vendor_with_image(title, phone, work_time, address, non_utility_service_type_id, image)
		response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
            :picture => { url: image }}.to_json,
            :headers => {'Content-Type' => 'application/json'})
	end

	def self.payload(data)
		response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/api/1.0/account/autoset?auth_token=#{Auth.get}",
	    	:body => { :payload => data}.to_json,
	    	:headers => {'Content-Type' => 'application/json'})
	end
end