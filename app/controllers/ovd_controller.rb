class OvdController < ApplicationController

	def ovd
		ovd = Ovd.count
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
