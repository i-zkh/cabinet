#encoding: UTF-8
class Xls < Parser

	def initialize(file, vendor_id)
    	@file = file
    	@vendor_id = vendor_id
  	end

	def input
		@data = case @vendor_id
				when 38, 46, 63, 59, 50, 129					then standard
				when 55, 47, 67, 66, 109, 110, 112, 114			then two_columns
				when 92											then sokol
				when 93											then debt_account
				when 58 										then three_columns
				when 15											then other
				when 56 										then first_four
				when 54 										then receipt
				when 42											then silver_creek
				when 120, 118, 119, 122, 123, 124, 125, 126		then one_column
				when 127										then one_column2
				when 62											then first_last
				else
					error = "Xls parser don't have method for #{Vendor.find(@vendor_id).title}. Vendor id: #{@vendor_id}"
					ReportMail.error(error, "[ERROR] Xls parser").deliver
				end
	end

	def create
	  	input
	  	super
	end

	def update
	  	input
	  	super
	end

	# === REPORT IN XLS
	#
	# жск_219, ТСЖ "Уют" (Демократическая, 2), жск 199, 298
	# Date from (7:А) to (7:N)
	#
	# == Example
	#
	# ЖЭУ	№ л/счета	Адрес					 Фамилия И. О.	  Расчетная площадь	 Кол-во проживающих	 Сальдо на 01/10/13	 Начислено	Период оплаты	Дата оплаты	 Оплачено  Пеня	 Списано сальдо  Сальдо на 30/11/13
	# 02	00001  		22-ПАРТСЪЕЗДА, 223-0001  ТУЛУМБАСОВА В.А. 65,00				 4					 3287,35			 6612,75	09/13			18.10.2013	 3400,00		 0,00	   		 3259		
	
	def standard
	    s = Roo::Excel.new(@file)
		key, data, address, hash = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], [], {}

		(7..s.last_row).each do |i|
			next if s.cell(i, 2) == 'ИТОГО' || s.cell(i, 2) == nil
			p address = s.cell(i, 3).to_s.split(",")
			  building = address[1].to_s.split("-")
			hash = {key[0] => s.cell(i, 2).gsub!(" ", "").to_i, key[1] => "Самара", key[2] => address[0], key[3] => building[0], key[4] => building[1].to_i, key[5] => s.cell(i, s.last_column)}
		  	data << hash
		end
		data
	end

	# ТСЖ Сокол
	# Date from (12:2) to (12:10)
	#
	# == Example
	#
	# Здание													Площ.	Кол-во прож.	Сумма на начало месяца	Итого начис-лено	Итого оплачено	Сумма на конец месяца
	# Лицевой счет	Кв-ра			Квартиросъемщик						
	# 446020, Самарская обл, Сызрань г, Комарова ул, дом № 2  	2693,1	82				88708,79				159048,63			83390,05		164367,37
	# л/с №1		Кв. 1			КНЯЗЕВА АЛЬБИНА СЕРГЕЕВНА	32,3	1				0						2372,46				2372,46	 		0
	
	def sokol
		s = Roo::Excel.new(@file)
	  	key, data, hash = ["user_account", "invoice_amount"], [], {}

  		(8..s.last_row-1).each do |i|
      		amount = s.cell(i, 5).nil? ? s.cell(i, 4) : s.cell(i, 5)
      		s.cell(i, 3) =~ /(\d+)/
      		hash =  {key[0] => $1, key[1] => amount}
  	  		data << hash
  		end
    	data	
	end

	# Серебрянный ручей
	# Date from (8:2) to (8:25)
	#
	# == Example
	#
	# № п/п	Лицевой счет							Общая площадь	Итого начислено		Сумма на конец месяца
	# 1	Кв. 1, Ирикова Ритта Константиновна, л/с №1	49,80			2434,07				2434,07

	def silver_creek
		s = Roo::Excel.new(@file)
	  	key, data, hash = ["user_account", "invoice_amount"], [], {}

  		(8..s.last_row-2).each do |i|
  			next if s.cell(i, 2) == nil
      		s.cell(i, 3) =~ /(\d+)/
      		hash =  {key[0] => $1, key[1] => s.cell(i, s.last_column)}
  	  		data << hash
  		end
    	data	
	end

	# ТСЖ Набережное
	# Date from (3:2) to (3:5)
	#
	# == Example
	#
	# начисления за сентябрь		№ лицевого счета	№ квартиры ФИО
	# 3296,70						00000000001			1 Алашеева А.Г.

	def debt_account
	    s = Roo::Excel.new(@file)
		  	key, data, hash = ["user_account", "invoice_amount"], [], {}

	  	(3..s.last_row).each do |i|
	  		next if s.cell(i, 5) == 'ИТОГО'
	  	  	hash =  {key[0] => s.cell(i, 4).to_i, key[1] => s.cell(i, 2)}
	  	  	data << hash
	  	end
	    data
	end

	# Ивушка
	# Date from (2:1) to (2:2)
	#
	# == Example
	#
	# л/сч	долг
	# 01	2 746,24

	def first_four
	    s = Roo::Excel.new(@file)
		  	key, data, hash = ["user_account", "invoice_amount"], [], {}

	  	(2..s.last_row).each do |i|
	  		next if s.cell(i, 1) == 'Итого'
	  	  	hash =  {key[0] => s.cell(i, 1).to_i, key[1] => s.cell(i, 2)}
	  	  	data << hash
	  	end
	    data
	end

	# жск 254
	# Date from (7:1) to (7:2)
	#
	# == Example
	#
	#  			Конечный остаток
	# л/сч		Задолженность
	# 			208247,25
	# 161-01	3 119,68

	def three_columns
		s = Roo::Excel.new(@file)
	  	key, data, hash = ["user_account", "invoice_amount"], [], {}

  		(7..s.last_row).each do |i|
      		invoice_amount = s.cell(i, 2) ? s.cell(i, 2) : s.cell(i, 3).to_f*(-1)
  	  		hash =  {key[0] => s.cell(i, 1), key[1] => invoice_amount}
  	  		data << hash
  		end
    	data
	end

	# PTS, жск 268, птс-сервис, Спорт, 29, Бизнес Центр
	# Date from (1:1)
	#
	# == Example
	#
	# Лицевые счета
	# 391001001

	def two_columns
		s = Roo::Excel.new(@file)
	  	key, data, hash = ["user_account", "invoice_amount"], [], {}
	  	(1..s.last_row).each do |i|
	  		next if s.cell(i, 1) == 'Л/С' || s.cell(i, 1) == "Лицевые счета" || s.cell(i, 1).nil? || s.cell(i, 1) == "Ном." || s.cell(i, 1) == "п/п" 
	  	  	hash =  {key[0] => s.cell(i, 1).to_i, key[1] => s.cell(i, 2)}
	  	  	data << hash
	  	end
    	data
	end


	# Промышленный №261 г.Самара ул.Губанова
	# Date from (2:1) to (2:2)
	#
	# == Example
	#
	# Наименование		долг
	# Дом 10 кв. 003	355,33

	def other
		s = Roo::Excel.new(@file)
		key, data, address, hash = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], [], {}
		(3..s.last_row).each do |i|
			next if s.cell(i, 1) == 'ЗАО "Самарагорэнергосбыт"' || s.cell(i, 1) == "Невыясненные платежи" || s.cell(i, 1) == "ОАО \"ПТС\"" || s.cell(i, 1) == "ООО \"Самарские коммунальные системы\"" || s.cell(i, 1) == "Поволжский СБ РФ" || s.cell(i, 1) == "Итого"
			address = s.cell(i, 1).to_s.split(" ")
			hash = {key[0] => address[3].to_i, key[1] => "Самара", key[2] => "Губанова", key[3] => address[1].to_i, key[4] => address[3], key[5] => s.cell(i, 2)}
		  	data << hash
		end
		data
	end

	# ТСЖ №275 квитанции
	def receipt
		s = Roo::Excel.new(@file)
		key, data, address, array, hash = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], [], [], {}
		(5..10).each do |i|
			p s.cell(i, 9) =~ /^[a-z]/
				# p s.cell(i-1, 9)
				# p address = s.cell(i-1, 9).split(",")
				# p array   =	address[1].split("-")
			# end
		end
		hash = {key[0] => address[1], key[1] => "Самара", key[2] => address[0], key[3] => array[0], key[4] => array[1], key[5] => s.cell(19, 9)}
		   data << hash
		data
	end

	# 138 Only for Samara
	# Date from (1:1)
	#
	# == Example
	#
	# ул.Мориса Тореза,139
	# 00001
	
	def one_column
		s = Roo::Excel.new(@file)
		key, data, address, hash = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], [], {}
		address = s.cell(1, 1).to_s.split(",")
		(2..s.last_row).each do |i|
			hash = {key[0] => s.cell(i, 1).to_i, key[1] => "Самара", key[2] => address[0], key[3] => address[1], key[4] => s.cell(i, 1).to_i, key[5] => ""}
		  	data << hash
		end
		data
	end
	
	# ЖСК №265
	# Date from (2:2)
	#
	# == Example
	#
	# Л/С
	# 1

	def one_column2
		s = Roo::Excel.new(@file)
		key, data, hash = ["user_account"], [], {}

	  	(2..s.last_row).each do |i|
	  	  	hash =  {key[0] => s.cell(i, 2).to_i}
	  	  	data << hash
	  	end
	    data
	end

	# ТСЖ №247 Б
	# Date from (3:1) to (3:4)
	#
	# == Example
	#
	# Лицевые счета ТСЖ № 247 "Б"   за ноябрь 2013 года			
	# № л/счёта	 сальдо на начало месяца	начисленно за текущий месяц	 итого к оплате
	# 30701		 4111,62					3895,37						 8006,99

	def first_last
		s = Roo::Excel.new(@file)
		key, data, hash = ["user_account", "invoice_amount"], [], {}

  		(3..s.last_row).each do |i|
  	  		hash =  {key[0] => s.cell(i, first_column), key[1] => s.cell(i, last_column)}
  	  		data << hash
  		end
    	data
	end

	
end