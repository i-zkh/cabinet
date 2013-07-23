class TxtController < ApplicationController
  def create
  	#Cyfral_samara
 # 	@vendor = TxtParser.input("TCDF1307.TXT")
    formatter = Formatter.new(TxtParser.new("TCDF1307.TXT", 1))
    formatter.input_data

    render json: true
  end
end
