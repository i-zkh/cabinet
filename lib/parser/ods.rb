#encoding: UTF-8
class Ods < Parser

  	def initialize(file, vendor_id)
    	@file = file
    	@vendor_id = vendor_id
  	end

	def input
		@data = case @vendor_id
				when 64, 65, 99 then first_colomn
				when 49 		then privolga
				else
					error = "Xls parser don't have method for #{Vendor.find(@vendor_id).title}. Vendor id: #{@vendor_id}"
					ReportMail.error(error, "[ERROR] Xls parser").deliver
					return
				end
	end

	def first_colomn
    	s = Roo::Openoffice.new(@file)
		key, @data, address, hash = ["user_account", "invoice_amount"], [], [], {}

		(2..s.last_row).each do |i|
			hash = {key[0] => s.cell(i, 1).to_i, key[1] => s.cell(i, 3)}
		  	@data << hash
		end
		@data
	end

	def privolga
    	s = Roo::Openoffice.new(@file)
		key, @data, address, hash = ["user_account", "invoice_amount"], [], [], {}

		(8..s.last_row).each do |i|
			next if s.cell(i, 3) == 'ИТОГО:' || s.cell(i, 3) == nil
			s.cell(i, 3) =~ /№(\d+)/
			hash = {key[0] => $1.to_i, key[1] => s.cell(i, 6)}
		  	@data << hash
		end
		@data
	end

    def create
	  	input
	  	super
	end

	def update
	  	input
	  	super
	end
	
end