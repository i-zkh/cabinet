#encoding: UTF-8
class AccountsController < ApplicationController

  def create
  	# 5, 33, 38, 40, 46, 47, 55, 58, 59, 61, 63, 64, 65, 67, 92, 93, 99

	# DataProcessing.amount_to_service(Getter.new(TxtParser.new("report/10-2013/Цифрал-Самара.TXT")).input_data, 5)
	# DataProcessing.amount_from_db(5)
	# DataProcessing.amount_from_db(33)
	# DataProcessing.amount_from_db(40)
	# DataProcessing.amount_from_db(38)
	# DataProcessing.amount_from_db(46)
	# DataProcessing.amount_from_db(55)
	# DataProcessing.amount_from_db(47)
	# DataProcessing.amount_from_db(58)
	# DataProcessing.amount_from_db(61)
	# DataProcessing.amount_from_db(59)
	# DataProcessing.amount_from_db(63)
	# DataProcessing.amount_from_db(64)
	# DataProcessing.amount_from_db(65)
	# DataProcessing.amount_from_db(67)
	# DataProcessing.amount_from_db(92)
	# DataProcessing.amount_from_db(93)
	# DataProcessing.amount_from_db(99)
	
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
	# Getter.create_accounts(Getter.new(Ods.new("report/10-2013/ЖСК №220.ods")).input_data, 99)

	# Add ТСЖ Набережное
	# Getter.create_accounts(Getter.new(XlsDebtAccount.new("report/10-2013/ТСЖ Набережное.xls")).input_data, 93)

	# Add Сокол
	# Getter.create_accounts(Getter.new(Sokol.new("report/10-2013/Сокол.xls")).input_data, 92)

	# Energosbyt
	# Getter.new(Energosbyt.new("report/10-2013/Сбыт_Энерго.xls")).input_data
	
	# Фриланс
	# Freelancer.new("report/10-2013/Фриланс.xls").add_freelancers
	# CheckEmail.get_organization
	# Getter.create_accounts(Getter.new(Dbf.new("report/10-2013/уют-7.DBF")).input_data, 33)

	# Ивушка
	# Getter.create_accounts(Getter.new(XlsFirstFour.new("report/10-2013/11.xls")).input_data, 56)

	# Промышленный №261
	# Getter.create_accounts(Getter.new(XlsOther.new("report/10-2013/#261.xls")).input_data, 15)

	############# Getter.new(Xls.new("report/10-2013/ЖСК199.xls", 63)).update
	
	# CheckEmail.get_organizations

	# @g = Getter.new(Xls.new("report/10-2013/11.xls", 58)).input
	# Osmp.check("0034586", DateTime.now)


	
	# Getter.new(Xls.new("report/11-2013/ТСЖ 247 б.xls", 62)).input
	# Getter.new(Ods.new("report/11-2013/privol.ods", 49)).input
	# Getter.new(Xls.new("report/11-2013/Лицевые Счета ЖСК №29.xls", 109)).input
	# Getter.new(Xls.new("report/11-2013/bus_center.xls", 110)).input

	# квитанции ТСЖ №275
	# Dir.foreach('report/11-2013/ТСЖ 275') do |file|
		# next if file == '.' or file == '..'
		# Getter.new(Xls.new("report/11-2013/ТСЖ 275/™Ґ®в†≠ж®п 221-6≠Ѓп°ам.xls", 54)).input
	# end

	# @g = Getter.new(Pdf.new("report/11-2013/Серебряный ручей.pdf", 42)).input
	
	#ЖСК-295
	# Getter.new(Dbf.new("report/11-2013/N0011310.DBF", 113)).input

	# Перспектива
	# Getter.new(Xls.new("report/11-2013/ТСЖ Перспектива.xls", 114)).create


	# Getter.new(Dbf.new("report/11-2013/сов 147.DBF", 112)).create
	# Getter.new(Xls.new("report/11-2013/Спорт3 реестр 10 13.xls", 111)).create

	# Getter.new(Xls.new("report/11-2013/промышленный № 261.xls", 15)).create
	# Getter.new(Xls.new("report/11-2013/254.xls", 58)).create
	# Getter.new(Xls.new("report/11-2013/ивушка.xls", 56)).create
	# Getter.new(Xls.new("report/11-2013/КЖСК № 298.xls", 50)).create
	# Getter.new(Xls.new("report/11-2013/ЖСК 138 выгрузка.xls", 120)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 136 выгрузка.xls", 122)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 100 выгрузка.xls", 126)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 96 выгрузка.xls", 124)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 9 выгрузка.xls", 125)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 11 выгрузка.xls", 119)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 137 выгрузка.xls", 123)).create
	# Getter.new(Xls.new("report/11-2013/Выгрузка ЖСК-265, ЛС.xls", 127)).create

	Getter.new(Ods.new("report/11-2013/приволжское.ods", 49)).create
	Getter.new(Xls.new("report/11-2013/ручей.xls", 42)).create

    render json: true
  end

  def update
  	# Цифрал
	# DataProcessing.update_accounts(Getter.new(TxtParser.new("report/10-2013/Цифрал-Самара.TXT")).input_data, 5)
	# DataProcessing.update_accounts(Getter.new(TxtParser.new("report/10-2013/ТЦД Цифрал-Сервис.TXT")).input_data, 40)


	# ПТС
	# DataProcessing.update_accounts(Getter.new(XlsForTwoColumns.new("report/10-2013/Абоненты ПТС на 01_10_2013.xls")).input_data, 47)

	# лидер
	# DataProcessing.update_accounts(Getter.new(Dbf.new("report/10-2013/N6801310.dbf")).input_data, 61)

	# ЖСК 254
	# Getter.update_accounts(Getter.new(XlsForThreeColumns.new("report/10-2013/ЖСК 254.xls")).input_data, 58)

	# ЖСК-219
	# Getter.update_accounts(Getter.new(Xls.new("report/10-2013/ЖСК - 219.xls")).input_data, 38)

	# Energosbyt.new("report/11-2013/energo.xls").create

	#Уют-7
	# Getter.new(Dbf.new("report/11-2013/N0012010.DBF", 33)).update
    render json: true
  end
end