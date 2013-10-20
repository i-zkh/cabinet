#encoding: UTF-8
class Sokol < Parser

  def initialize(file)
    @file = file
  end

  def input
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
end