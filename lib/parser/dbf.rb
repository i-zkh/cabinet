#encoding: utf-8
require 'dbf'
class Dbf < Parser

  	def initialize(file, vendor_id)
    	@file = file
    	@vendor_id = vendor_id
  	end

	def input
		@data = case @vendor_id
				when 61, 111, 33 then parser
				else
				end
		super
	end

    def create
	  	input
	  	super
	end

	def update
	  	input
	  	super
	end
	
	def parser
		table = DBF::Table.new(@file)
		key, @data, hash = ["user_account", "city", "street", "building", "apartment", "invoice_amount"], [], {}
		
		table.each do |record|
			record.adr =~ /(\W+),(\d+)-(\d+)/
		    hash = {key[0] => record.kod.to_i, key[1] => "Самара", key[2] => $1, key[3] => $2, key[4] => $3, key[5] => record.sumd}
		    @data << hash
		end
		@data
	end
end