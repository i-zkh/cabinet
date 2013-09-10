#encoding: UTF-8
class Xls < Parser

  def initialize(file)
    @file = file
  end

  def input
   s = Roo::Excel.new(@file)
	key, data, array = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], []
	hash = {}

	(2..s.last_row-1).each do |i|
		array = s.cell(i, 3).to_s.gsub!(", ", '-').to_s.split("-")

		hash = {key[0] => s.cell(i, 2), key[1] => "Самара", key[2] => array[0], key[3] => array[1], key[4] => array[2].to_i, key[5] => s.cell(i, 16)}
	  data << hash
	end
	 return data
  end

end