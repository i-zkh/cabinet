class OvdController < ApplicationController

	def ovd
		ovd = Ovd.xls_parser
		render json: ovd
	end

	def xls
		@data = Ovd.xml_to_xsl
    	respond_to do |format|
    		format.html
      		format.xls
    	end	
	end
end
