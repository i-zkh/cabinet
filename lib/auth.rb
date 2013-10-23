class Auth 
	def self.get 
		response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
        	:body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
        	:headers => { 'Content-Type' => 'application/json' })
        response.parsed_response["user"]["auth_token"]
	end
end