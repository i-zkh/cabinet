class CreateVendor
	def  initialize(title, service_type_id)
		@service_type_id = service_type_id
		@title = title
		@is_active = true
	end

	def request
	response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
        	:body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
        	:headers => { 'Content-Type' => 'application/json' })
        @auth = response.parsed_response["user"]["auth_token"]
        
  	response = HTTParty.post( "https://izkh.ru/api/1.0/vendor",
    	:body => { :vendor =>  { :title => @title, :service_type_id => @service_type_id, :is_active => @is_active }, 
    	:auth_token => @auth}.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["vendor"]
	end
end