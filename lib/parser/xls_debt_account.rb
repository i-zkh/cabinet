#encoding: UTF-8
class XlsDebtAccount < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Excel.new(@file)
	  key, data = ["user_account", "invoice_amount"], [] 
	  hash = {}


  	(3..s.last_row).each do |i|
  	  next if s.cell(i, 5) == 'ИТОГО'
  	  hash =  {key[0] => s.cell(i, 4).to_i, key[1] => s.cell(i, 2)}
  	  data << hash
  	end
    data
  end

end