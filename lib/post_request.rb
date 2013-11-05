#encoding: utf-8
require 'open-uri'
class PostRequest
	class << self
		
		def non_utility_service_type(title)
		  	response = HTTParty.post( "https://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}",
		    	:body => { :non_utility_service_type => { title: title }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def servicetype(title)
		  	response = HTTParty.post( "https://izkh.ru/api/1.0/servicetype?auth_token=#{Auth.get}",
		    	:body => { :service_type => { title: title }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def non_utility_vendor(title, phone, work_time, address, non_utility_service_type_id, geocode)
			response = HTTParty.post( "https://izkh.ru/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
	            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
	            		   :picture => { url: "http://static-maps.yandex.ru/1.x/?ll=#{geocode}&z=15&l=map&size=300,200&pt=#{geocode}" }}.to_json,
	            :headers => {'Content-Type' => 'application/json'})
		end

		def non_utility_vendor_with_image(title, phone, work_time, address, non_utility_service_type_id, image)
			response = HTTParty.post( "https://izkh.ru/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
	            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
	            :picture => { url: image }}.to_json,
	            :headers => {'Content-Type' => 'application/json'})
		end

		def vendor(title, service_type_id, commission, cities)
			response = HTTParty.post( "https://izkh.ru/api/1.0/vendor?auth_token=#{Auth.get}",
		    	:body => { :vendor =>  { title: title, service_type_id: service_type_id, is_active: true, commission: commission, merchant_id: 43222, psk: "e45a8c7b-b0bd-4bdd-93d3-859b463daf81" },
		    			   :cities => cities }.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def field_template(tariff_template_id)
			response = HTTParty.post( "https://izkh.ru/api/1.0/field_template?auth_token=#{Auth.get}",
	    		:body => { :field_template => { title: "Минимальная сумма платежа", value: 0, is_for_calc: false, tariff_template_id: tariff_template_id, field_type: "text_field", field_units: "руб"}}.to_json,
	    		:headers => {'Content-Type' => 'application/json'})
		end

		def tariff_template(vendor_id, service_type_id)
			title = [ 0, "", "Оплата домофона", "", "Оплата коммунальных услуг", "Оплата интернета", "Оплата услуг охраны", "Оплата горячей воды и тепла", "Оплата услуг по утилизации отходов" ]
			response = HTTParty.post( "https://izkh.ru/api/1.0/tariff_template?auth_token=#{Auth.get}",
	    		:body => { :tariff_template => { title: title[service_type_id], vendor_id: vendor_id, has_readings: false, service_type_id: service_type_id }}.to_json,
	    		:headers => {'Content-Type' => 'application/json'})
		end

		def freelancer(freelance_category_id, description, phone, title, name)
		  	response = HTTParty.post( "https://izkh.ru/api/1.0/freelancer/create?auth_token=#{Auth.get}",
		    	:body => { freelancer: { freelance_category_id: freelance_category_id, description: description, phone: phone, title: title, work_time: "", name: name}}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def payload(data)
			response = HTTParty.post( "https://izkh.ru/api/1.0/account/autoset?auth_token=#{Auth.get}",
		    	:body => { :payload => data}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def precinct(ovd, ovd_town, ovd_street, ovd_house, ovd_telnumber, surname, name, middlename)
			response = HTTParty.post( "https://izkh.ru/api/1.0/precinct/create?auth_token=#{Auth.get}",
		    	:body => { :precinct => { ovd: ovd, ovd_town: ovd_town, ovd_street: ovd_street, ovd_house: ovd_house, ovd_telnumber: ovd_telnumber, surname: surname, name: name, middlename: middlename }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def precinct_territory(precinct_id, street, house)
			response = HTTParty.post( "https://izkh.ru/api/1.0/precinct_territorty/create?auth_token=#{Auth.get}",
		    	:body => { :precinct_territory => { precinct_id: precinct_id, street: street, house: house }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

	end
end