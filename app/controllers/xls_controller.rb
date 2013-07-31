class XlsController < ApplicationController
  def create
  	#PTS_06_2013
  	#getter = Getter.new(XlsForTwoColumnParser.new("PTS_06_2013.xls", 2))
    #getter.input_data

    render json: true
  end
end
