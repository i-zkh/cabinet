class Formatter
	attr_accessor :parser

	def initialize(parser)
		@parser = parser
	end

	def input_data
		@parser.input
	end
end