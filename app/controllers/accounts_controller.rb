#encoding: UTF-8
class AccountsController < ApplicationController

  def create
	# DataProcessing.amount_to_service(Getter.new(TxtParser.new("report/10-2013/Цифрал-Самара.TXT")).input_data, 5)
	# DataProcessing.amount_from_db(5)
	# DataProcessing.amount_from_db(40)
	# DataProcessing.amount_from_db(38)
	# DataProcessing.amount_from_db(46)
	# DataProcessing.amount_from_db(55)
	# DataProcessing.amount_from_db(47)
	# DataProcessing.amount_from_db(58)
	# DataProcessing.amount_from_db(61)

	# Add жск_219, ТСЖ "Уют" (Демократическая, 2), жск 199
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("report/9-2013/жск_219.xls")).input_data, 38)
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("report/9-2013/VOKU1.xls")).input_data, 46)
	# DataProcessing.push_data_to_account(Getter.new(Xls.new("report/10-2013/ЖСК199.xls")).input_data, 63)
	# Getter.create_accounts(Getter.new(Xls.new("report/10-2013/249.xls")).input_data, 59)
	
	# Add Цифрал
	# DataProcessing.push_data_to_account(Getter.new(TxtParser.new("report/10-2013/ТЦД Цифрал-Сервис.TXT")).input_data, 40)
	# DataProcessing.push_data_to_account(Getter.new(TxtParser.new("report/10-2013/Цифрал-Самара.TXT")).input_data, 5)
	# @report = Getter.new(XlsForThreeColumns.new("report/9-2013/254.xls")).input_data


	# Add PTS, жск 268
	# DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("report/9-2013/жск 268 август.xls")).input_data, 55)
#!	  ADD TO_I to user_account
	# DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("report/9-2013/Абоненты ПТС на 01_10_2013.xls")).input_data, 47)
	
	# DataProcessing.push_data_to_account(Getter.new(XlsForTwoColumns.new("report/10-2013/Абоненты ПТС на 01_10_2013.xls")).input_data, 67)

	# Add жск 254
	# DataProcessing.push_data_to_account(Getter.new(XlsForThreeColumns.new("report/9-2013/254.xls")).input_data, 58)

	# Add тсж Лидер
	# DataProcessing.push_data_to_account(Getter.new(Dbf.new("report/9-2013/тсж Лидер.DBF")).input_data, 61)

	# Add ЖСК №224, Лагуна, ЖСК №220
	# DataProcessing.push_data_to_account(Getter.new(Ods.new("report/9-2013/ЖСК №224.ods")).input_data, 64)
	# DataProcessing.push_data_to_account(Getter.new(Ods.new("report/9-2013/ТСЖ \"Лагуна\".ods")).input_data, 65)
	Getter.create_accounts(Getter.new(Ods.new("report/10-2013/ЖСК №220.ods")).input_data, 99)

	# Add ТСЖ Набережное
	# Getter.create_accounts(Getter.new(XlsDebtAccount.new("report/10-2013/ТСЖ Набережное.xls")).input_data, 93)

	# Add Сокол
	# Getter.create_accounts(Getter.new(Sokol.new("report/10-2013/Сокол.xls")).input_data, 92)

	# Energosbyt
	# Getter.new(Energosbyt.new("report/10-2013/Сбыт_Энерго.xls")).input_data
	
	# Фриланс
	# Freelancer.new("report/10-2013/Фриланс.xls").add_freelancers
	# CheckEmail.get_organization
    render json: true
  end

  def update
  	# Цифрал
	# DataProcessing.update_accounts(Getter.new(TxtParser.new("report/10-2013/Цифрал-Самара.TXT")).input_data, 5)
	# DataProcessing.update_accounts(Getter.new(TxtParser.new("report/10-2013/ТЦД Цифрал-Сервис.TXT")).input_data, 40)


	# ПТС
	# DataProcessing.update_accounts(Getter.new(XlsForTwoColumns.new("report/10-2013/Абоненты ПТС на 01_10_2013.xls")).input_data, 47)

	# лидер
	# DataProcessing.update_accounts(Getter.new(Dbf.new("report/10-2013/лидер.dbf")).input_data, 61)

	#ЖСК 254
	Getter.update_accounts(Getter.new(XlsForThreeColumns.new("report/10-2013/ЖСК 254.xls")).input_data, 58)

    render json: true
  end
end