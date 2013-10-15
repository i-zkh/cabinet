#encoding: UTF-8
class XlsForTwoColumns < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Excel.new(@file)
	  key, data = ["user_account", "invoice_amount"], [] 
	  hash = {}

  	(1..s.last_row).each do |i|
  	  hash =  {key[0] => s.cell(i, 1), key[1] => s.cell(i, 2)}
  	  data << hash
  	end
    data
  end
end