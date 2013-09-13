class Auth 
	def self.get 
		response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/users/sign_in.json",
        	:body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
        	:headers => { 'Content-Type' => 'application/json' })
        response.parsed_response["user"]["auth_token"]
	end
end