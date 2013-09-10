#encoding: UTF-8
class TxtParser < Parser

  def initialize(file)
    @file = file
  end

  def input
	data, row = [], []
	key = ["user_account", "city", "street", "building", "apartment", "invoice_amount"]
	File.open(@file, 'r:windows-1251:utf-8').each do |r|
		row << r
	end
	row.each do |num|
		num.gsub!(", ", ';')
		array = num.split(";")
 		hash = { key[0] => array[0], key[1] => array[1], key[2] => array[2], key[3] => array[3], key[4] => array[4], key[5] => array[5]}
		data << hash
	end
	return data
  end
end