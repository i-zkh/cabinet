#encoding: utf-8
require 'russian'
class WebReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(filename, vendor_id)
	  	case File.extname(filename).downcase
      	when ".txt" then Getter.new(Txt.new(filename, vendor_id)).create
      	when ".xls", ".xlsx" 
        	if vendor_id == 107
          		Energosbyt.new(filename).update
        	else
          		Getter.new(Xls.new(filename, vendor_id)).create
        	end
      	when ".dbf" then Getter.new(Dbf.new(filename, vendor_id)).create
      	when ".ods" then Getter.new(Ods.new(filename, vendor_id)).create
      	else
        	raise ArgumentError, 'file have not a sample'
      	end
    end
end
