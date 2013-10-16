#encoding: utf-8
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'sidekiq'
require 'clockwork'

module Clockwork
  every(5.minutes, 'Report') do
   Sidekiq.logger.info "Starting Report"
   Report.report
 end
end