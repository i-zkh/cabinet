class Getter
	attr_accessor :parser

	def initialize(parser)
		@parser = parser
	end

	def input
		@parser.input
	end

	def create
		@parser.create
	end

	def update
		@parser.update
	end
end