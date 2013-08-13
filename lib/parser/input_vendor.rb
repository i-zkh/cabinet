class InputVendor < Parser

  def initialize(file)
    @file = file
  end

  def input
   s = Roo::Excel.new(@file)

	key = Array.new 
	data = Array.new 
	hash = Hash.new 

	key = ["title", "commission", "email"]
	(2..s.last_row).each do |i|
		if s.cell(i, 2) == 2.0
			hash =  {key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10)}
	 		data << hash
	    end
	end

	#(0..data.size-1).each do |i|
    #		Vendor.create!(title: data[i]["title"], commission: data[i]["commission"], email: data[i]["email"] )
	#end
	#vendor = CreateVendor.new(data[i]["title"], 4)
	#vendor.request
  end
end