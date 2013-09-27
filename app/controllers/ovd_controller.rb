class OvdController < ApplicationController

	def ovd
		Ovd.xml_parser
		render json: true
	end
end
