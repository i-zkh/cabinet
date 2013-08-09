class CreateFieldTemplate

	def  initialize(title, value, is_for_calc, tariff_template_id, field_type, field_units, auth)
		@title = title
		@value = value
		@is_for_calc = is_for_calc
		@tariff_template_id = tariff_template_id
		@field_type = field_type
		@field_units = field_units
		@auth = auth
	end

	def request
  	response = HTTParty.post( "https://izkh.ru/api/1.0/field_template",
    	:body => { :field_template =>  { :title => @title, :value => @value, :is_for_calc => @is_for_calc, :tariff_template_id => @tariff_template_id, :field_type => @field_type, :field_units => @field_units},
    	:auth_token => @auth }.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["field_template"]
	end
end