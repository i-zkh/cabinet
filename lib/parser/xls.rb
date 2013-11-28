#encoding: UTF-8
class Xls < Parser

	def initialize(file, vendor_id)
    	@file = file
    	@vendor_id = vendor_id
  	end

	def input
		@data = case @vendor_id
				when 38, 46, 63, 59, 50 						then standard
				when 55, 47, 67, 62, 109, 110, 111, 114		 	then two_columns
				when 92											then sokol
				when 93											then debt_account
				when 58 										then three_columns
				when 15											then other
				when 56 										then first_four
				when 54 										then receipt
				when 42											then silver_creek
				when 120, 118, 119, 122, 123, 124, 125, 126		then one_column
				when 127										then one_column2
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

	# жск_219, ТСЖ "Уют" (Демократическая, 2), жск 199, 298 
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

	# Сокол
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

	# PTS, жск 268, птс-сервис, №247 б, Спорт, 29, Бизнес Центр
	def two_columns
		s = Roo::Excel.new(@file)
	  	key, data, hash = ["user_account", "invoice_amount"], [], {}
	  	p s.cell(1, 1)
	  	(1..s.last_row).each do |i|
	  		next if s.cell(i, 1) == 'Л/С' || s.cell(i, 1) == "Лицевые счета"
	  	  	hash =  {key[0] => s.cell(i, 1).to_i, key[1] => s.cell(i, 2)}
	  	  	data << hash
	  	end
    	data
	end

	# Промышленный №261
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

	def one_column2
		s = Roo::Excel.new(@file)
		key, data, hash = ["user_account"], [], {}

	  	(2..s.last_row).each do |i|
	  	  	hash =  {key[0] => s.cell(i, 2).to_i}
	  	  	data << hash
	  	end
	    data
	end
	
end