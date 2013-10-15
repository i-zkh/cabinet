#encoding: UTF-8
class Xls < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Excel.new(@file)
	key, data, address = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], []
	hash = {}

	(7..s.last_row).each do |i|
		next if s.cell(i, 2) == 'ИТОГО'
		address = s.cell(i, 3).to_s.gsub!(", ", '-').to_s.split("-")

		hash = {key[0] => s.cell(i, 2).gsub!(" ", "").to_i, key[1] => "Самара", key[2] => address[0], key[3] => address[1], key[4] => address[2].to_i, key[5] => s.cell(i, 16)}
	  data << hash
	end
	data
  end

end