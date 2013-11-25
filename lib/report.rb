#encoding: utf-8
class Report
	attr_accessor :payload

	def initialize(payload)
		@payload = payload
	end

	def output_report
		@payload.output
	end

	def monthly
		@payload.monthly
	end

	def self.report
        ReportWorker.perform_async
    end

    def self.report_hourly
        ReportHourlyWorker.perform_async
    end
end