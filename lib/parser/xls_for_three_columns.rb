#encoding: UTF-8
class XlsForThreeColumns < Parser

  def initialize(file)
    @file = file
  end

  def input
    s = Roo::Excel.new(@file)
	  key, data, hash = ["user_account", "invoice_amount"], [], {}

  	(7..s.last_row).each do |i|
      invoice_amount = s.cell(i, 2) ? s.cell(i, 2) : s.cell(i, 3).to_f*(-1)
  	  hash =  {key[0] => s.cell(i, 1), key[1] => invoice_amount}
  	  data << hash
  	end
    data
  end
end

#hash =  [s.cell(i, 1), "", "", "", "",  invoice_amount]