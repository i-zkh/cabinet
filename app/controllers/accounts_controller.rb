#encoding: UTF-8
class AccountsController < ApplicationController

  def create
	#DataProcessing.amount_to_service(Getter.new(TxtParser.new("report/9-13/Цифрал-Самара.TXT")).input_data, 5)

	# Add жск_219, ТСЖ "Уют" (Демократическая,2) 
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("report/9-13/жск_219.xls")).input_data, 38)
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("report/9-13/VOKU1.xls")).input_data, 46)

	# Add Цифрал
	#DataProcessing.push_data_to_account(Getter.new(TxtParser.new("report/9-13/ТЦД Цифрал-Сервис.TXT")).input_data, 5)

	# Add PTS, жск 268
	# DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("report/9-13/жск 268 август.xls")).input_data, 55)
#!	  ADD TO_I to user_account
	#DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("report/9-13/PTS_06_2013.xls")).input_data, 47)

	#Add жск 254
	# DataProcessing.push_data_to_account(Getter.new(XlsForThreeColumns.new("report/9-13/254.xls")).input_data, 58)

	#Add тсж Лидер
	# DataProcessing.push_data_to_account(Getter.new(Dbf.new("report/9-13/тсж Лидер.DBF")).input_data, 61)

	#Add ЖСК №224, Лагуна
	#DataProcessing.push_data_to_account(Getter.new(Ods.new("report/9-13/ЖСК №224.ods")).input_data, )

	# Freelancer.new("Фриланс.xls").add_freelancers
	Getter.new(Energosbyt.new("report/9-13/Энергосбыт.xls")).input_data

    render json: true
  end
end