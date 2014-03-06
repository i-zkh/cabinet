#encoding: utf-8
require 'russian'
class WebReportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(data, vendor_id)
	  	Parser.create(data, vendor_id)
    end
end
