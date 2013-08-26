class AddServicetypeToService
	def  initialize(title)
		@title = title
	end

	def add
	  	response = HTTParty.post( "https://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}",
	    	:body => { :non_utility_service_type =>  { :title => @title }}.to_json,
	    	:headers => { 'Content-Type' => 'application/json' })
	end
end