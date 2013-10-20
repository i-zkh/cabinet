class OvdController < ApplicationController

	def ovd
		Ovd.xml_parser
		render json: true
	end

	def xls
		@data = Ovd.xml_to_xsl
    	respond_to do |format|
    		format.html
      		format.xls
    	end	
	end
end
