class XlsController < ApplicationController
  def create
  	#PTS_06_2013
  	#getter = Getter.new(XlsForTwoColumnParser.new("PTS_06_2013.xls", 2))
    #getter.input_data
	getter = Organization.new("Organizations.xls")
    getter.non_utility_vendor_create
    #getter.non_utility_vendor_create
    render json: true
  end
end
