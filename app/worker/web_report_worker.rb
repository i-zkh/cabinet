#encoding: utf-8
require 'russian'
class WebReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(filename, vendor_id)
    case File.extname(filename).downcase
      when ".txt"          then @data = Getter.new(Txt.new(filename, vendor_id)).input
      when ".xls", ".xlsx" then @data = Getter.new(Xls.new(filename, vendor_id)).input
      when ".dbf"          then @data = Getter.new(Dbf.new(filename, vendor_id)).input
      when ".ods"          then @data = Getter.new(Ods.new(filename, vendor_id)).input
      else
        raise ArgumentError, 'file have not a sample'
      end
	  	Parser.create(@data, vendor_id)
    end
end
