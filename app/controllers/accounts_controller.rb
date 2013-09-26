#encoding: UTF-8
class AccountsController < ApplicationController

  def create
	#DataProcessing.amount_to_service(Getter.new(TxtParser.new("Цифрал-Самара.TXT")).input_data, 5)

	# Add жск_219, ТСЖ "Уют" (Демократическая,2) 
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("жск_219.xls")).input_data, 38)
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("VOKU1.xls")).input_data, 46)

	# Add Цифрал
	#DataProcessing.push_data_to_account(Getter.new(TxtParser.new("ТЦД Цифрал-Сервис.TXT")).input_data, 5)

	# Add PTS, жск 268
	# DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("жск 268 август.xls")).input_data, 55)
	#!!!!!!!! ADD TO_I to user_account
	#DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("PTS_06_2013.xls")).input_data, 47)

	#Add жск 254
	# DataProcessing.push_data_to_account(Getter.new(XlsForThreeColumns.new("254.xls")).input_data, 58)

	#Add тсж Лидер
	 DataProcessing.push_data_to_account(Getter.new(Dbf.new("тсж Лидер.DBF")).input_data, 61)

    render json: true
  end

end