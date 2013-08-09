require 'celluloid/autostart'
module AwesomeRailsApp
  class ClockworkScheduler
    include Celluloid
    include Clockwork
 
    def run
      # I'd wait 20 seconds for workers to boot completely and process pending jobs
      sleep 20
      Sidekiq.logger.info "Starting Clockwork Thread Fiber"
      Clockwork::run
    rescue => ex
      return if ex.is_a?(Celluloid::Task::TerminatedError)
      Sidekiq.logger.info "ClockworkScheduler Thread failed! - "+ex.message+"\n"+ex.backtrace.join("\n")
    end
  end
end