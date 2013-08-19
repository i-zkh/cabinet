class Organization
	
  def initialize(file)
    @file = file

    s = Roo::Excel.new(@file)
	key = Array.new 
	@data = Array.new 
	hash = Hash.new 

	key = ["title", "commission", "email", "phone", "address"]
	(2..s.last_row).each do |i|
		if s.cell(i, 2) == 2.0
			hash =  {key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11) }
	 		@data << hash
	    end
	end
  end

  def add_absence_vendor
  	(0..@data.size-1).each do |i|
  		vendor = Vendor.where(title: @data[i]["title"]).first
  		if !vendor
  			p @data[i]["title"]
  			#Vendor.create!(title: data[i]["title"], commission: data[i]["commission"], email: data[i]["email"])
  			#vendor = CreateVendor.new(data[i]["title"], 4)
			#vendor.request
  		end
  	end
  end

  def list_vendor
  	response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
        :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
        :headers => { 'Content-Type' => 'application/json' })
    @auth = response.parsed_response["user"]["auth_token"]
        
  	response = HTTParty.post( "https://izkh.ru/api/1.0/vendor",
    	:body => { :vendor =>  { :title => @data[i]["title"], :phone =>  @data[i]["phone"], :address => @data[i]["address"] }, 
    	:auth_token => @auth}.to_json,
    	:headers => { 'Content-Type' => 'application/json' })
    return response.parsed_response["vendor"]
  end

end