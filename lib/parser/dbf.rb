require 'dbf'
class Dbf < Parser

  def initialize(file)
    @file = file
  end

  def input
	p widgets = DBF::Table.new(@file)
	key, data = ["user_account", "invoice_amount"], []
	hash = {}

	widgets.each do |record|
	  puts record
	end
  end
end