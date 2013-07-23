class Report
	attr_accessor :payload

	def initialize(payload)
		@payload = payload
	end

	def output_report
		@payload.output
	end
end