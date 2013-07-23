class XlsController < ApplicationController
  def create
  	#PTS_06_2013
  	formatter = Formatter.new(XlsForTwoColumnParser.new("PTS_06_2013.xls", 2))
    formatter.input_data

    render json: true
  end
end
