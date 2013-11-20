#encoding: utf-8
class Pdf < Parser

  def initialize(file, vendor_id)
    @file = file
    @vendor_id = vendor_id
  end

	def input
		array, page = [], []
		reader = PDF::Reader.new(@file)
		
		reader.pages.each do |page|
		  array << page = page.text
		end
		array
	end

    def create
	  	input
	  	super
	end

	def update
	  	input
	  	super
	end
	
end