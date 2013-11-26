#encoding: utf-8
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'sidekiq'
require 'clockwork'

module Clockwork
	every(1.day, 'Report', :at => '22:00') do
		Sidekiq.logger.info "Starting Report"
   		Report.report
 	end

 	every(1.day, 'Report', :at => '4:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '7:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '10:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '13:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '16:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '18:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end

 	every(1.day, 'Report', :at => '21:00') do
		Sidekiq.logger.info "Starting Report hourly"
   		Report.report_hourly
 	end
end