#encoding: UTF-8
class Ods < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Openoffice.new(@file)
	key, data, address, hash = ["user_account", "invoice_amount"], [], [], {}

	(2..s.last_row).each do |i|
		hash = {key[0] => s.cell(i, 1).to_i, key[1] => s.cell(i, 3)}
	  	data << hash
	end
	data
  end
end