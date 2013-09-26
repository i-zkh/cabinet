#encoding: UTF-8
class XlsForThreeColumns < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Excel.new(@file)
	  key, data = ["user_account", "invoice_amount"], [] 
	  hash = {}

  	(7..s.last_row).each do |i|
      invoice_amount = s.cell(i, 2)? s.cell(i, 2) : s.cell(i, 3).to_f*(-1)
  	  hash =  {key[0] => s.cell(i, 1), key[1] => invoice_amount}
  	  data << hash
  	end
    data
  end
end