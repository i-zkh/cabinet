class AddVendorToService
	def  initialize(title, service_type_id)
		@service_type_id = service_type_id
		@title = title
		@is_active = true
	end

	def add
	  	response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/api/1.0/vendor",
	    	:body => { :vendor =>  { :title => @title, :service_type_id => @service_type_id, :is_active => @is_active }, 
	    	:auth_token => Auth.get }.to_json,
	    	:headers => { 'Content-Type' => 'application/json' })
	    return response.parsed_response["vendor"]
	end
end