#encoding: utf-8
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'sidekiq'
require 'clockwork'

module Clockwork
    # Clock for Daily report
	every(1.day, 'Report', :at => '21:00') do
		Sidekiq.logger.info "Starting Report daily"
   		Report.report
 	end
    
    # Clock for hourly report
 	every(1.day, 'Report', :at => ['4:00', '07:00', '10:00', '13:00', '16:00', '19:00', '22:00', '01:00']) do
    	Sidekiq.logger.info "Starting Report hourly"
        Report.report_hourly
    end

	every(1.day, 'monthly report for', :at => '08:30', :if => lambda { |t| t.day == 3 }) { MonthlyReportWorker.perform_async }

end