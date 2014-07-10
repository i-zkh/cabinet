#encoding: utf-8
require 'open-uri'
class PostRequest
	class << self
		
		def non_utility_service_type(title)
		  	response = HTTParty.post( "http://izkh.ru/api/1.0/nonutilityservicetype",
		    	:body => { :non_utility_service_type => { title: title }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def servicetype(title)
		  	response = HTTParty.post( "http://izkh.ru/api/1.0/servicetype",
		    	:body => { :service_type => { title: title }}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def non_utility_vendor(title, phone, work_time, address, non_utility_service_type_id, geocode)
			response = HTTParty.post( "http://izkh.ru/api/1.0/non_utility_vendor",
	            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
	            		   :picture => { url: "http://static-maps.yandex.ru/1.x/?ll=#{geocode}&z=15&l=map&size=300,200&pt=#{geocode}" }}.to_json,
	            :headers => {'Content-Type' => 'application/json'})
		end

		def non_utility_vendor_with_image(title, phone, work_time, address, non_utility_service_type_id, image)
			response = HTTParty.post( "http://izkh.ru/api/1.0/non_utility_vendor",
	            :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
	            :picture => { url: image }}.to_json,
	            :headers => {'Content-Type' => 'application/json'})
		end

		def non_utility_vendors_contact(non_utility_vendor_id, title, phone)
			response = HTTParty.post( "http://izkh.ru/api/1.0/non_utility_vendors_contact",
	            :body => { :non_utility_vendors_contacts => { title: title, phone: phone, non_utility_vendor_id: non_utility_vendor_id }}.to_json,
	            :headers => {'Content-Type' => 'application/json'})
		end

		def vendor(title, service_type_id, commission, commission_yandex, commission_ya_card, commission_web_money, commission_ya_cash_in, shop_article_id)
			response = HTTParty.post( "http://izkh.ru/api/1.0/vendors",
		    	:body => { :vendor =>  { title: title, service_type_id: service_type_id, commission: commission, commission_yandex: commission_yandex, commission_ya_card: commission_ya_card, commission_web_money: commission_web_money, commission_ya_cash_in: commission_ya_cash_in, shop_article_id: shop_article_id}}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def field_template(tariff_template_id)
			response = HTTParty.post( "http://izkh.ru/api/1.0/field_template",
	    		:body => { :field_template => { title: "Минимальная сумма платежа", value: 100, is_for_calc: false, tariff_template_id: tariff_template_id, field_type: "text_field", field_units: "руб"}}.to_json,
	    		:headers => {'Content-Type' => 'application/json'})
		end

		def tariff_template(vendor_id, service_type_id)
			title = [ 0, "", "Оплата домофона", "", "Оплата коммунальных услуг", "Оплата интернета", "Оплата услуг охраны", "Оплата горячей воды и тепла", "Оплата услуг по утилизации отходов" ]
			response = HTTParty.post( "http://izkh.ru/api/1.0/tariff_template",
	    		:body => { :tariff_template => { title: title[service_type_id], vendor_id: vendor_id, has_readings: false, service_type_id: service_type_id }}.to_json,
	    		:headers => {'Content-Type' => 'application/json'})
		end

		def freelancer(freelance_category_id, description, phone, title, name)
		  	response = HTTParty.post( "http://izkh.ru/api/1.0/freelancer/create",
		    	:body => { freelancer: { freelance_category_id: freelance_category_id, description: description, phone: phone, title: title, work_time: "", name: name}}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def payload(data)
			response = HTTParty.post( "http://izkh.ru/api/1.0/account/autoset",
		    	:body => { :payload => data}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		def metrics_process(utility_metrics)
			response = HTTParty.post( "http://izkh.ru/utility_metrics/process",
		    	:body => {:utility_metrics => utility_metrics}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end

		#Notification
		def notification(body, vendor_id)
			response = HTTParty.post( "http://izkh.ru/notifications",
		    	:body => {notification_text: body, vendor_id: vendor_id}.to_json,
		    	:headers => {'Content-Type' => 'application/json'})
		end
	end
end