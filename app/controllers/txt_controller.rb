#encoding: UTF-8
class TxtController < ApplicationController

  def create
	#DataProcessing.amount_to_service(Getter.new(TxtParser.new("Цифрал-Самара.TXT")).input_data, 5)
	DataProcessing.push_data_to_db(Getter.new(Xls.new("жск_219.xls")).input_data, 38)


    render json: true
  end

end