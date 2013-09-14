#encoding: utf-8
require 'russian'
class ReportWorker
  include Sidekiq::Worker

     def perform
	   		ReportMail.no_transactions.deliver
    end
end
