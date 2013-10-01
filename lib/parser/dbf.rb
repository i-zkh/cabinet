#encoding: utf-8
require 'dbf'
require 'iconv'
class Dbf < Parser

  def initialize(file)
    @file = file
  end

  def input
	table = DBF::Table.new(@file)
	key, data = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], []
	hash = {}

	table.each do |record|
		record.adr =~ /(\W+),(\d+)-(\d+)/
	    hash = {key[0] => record.kod.to_i, key[1] => "Самара", key[2] => $1, key[3] => $2, key[4] => $3, key[5] => record.sumd}
	    data << hash
	end
	data
  end
end