class OvdController < ApplicationController

	def ovd
		Ovd.xls_parser("report/ovd_19.03.14.xls")
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
