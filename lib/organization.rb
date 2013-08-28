#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetype = servicetype
  end

  def add_absence_vendor
    check_servicetype
  	(0..@data.size-1).each do |i|
    #  geocode = GetRequest.geocode(@data[i]["address"])
 		  vendor = Vendor.where(title: @data[i]["title"]).first
 		if !vendor
 	   (0..@servicetype.size-1).each do |j|
       if @servicetype[j]["title"].mb_chars.downcase.to_s == @data[i]["servicetype"]
          #PostRequest.vendor(@data[i]["title"], @servicetype[j]["id"])

          #PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, "уточните по телефону", @data[i]["address"], @servicetype[j]["id"], geocode)

         #k = (0...5).map{('a'..'z').to_a[rand(26)]}.join
         #vendor_key = Digest::MD5.hexdigest(k)
         p @data[i]["title"]
        # Vendor.create!(title: @data[i]["title"], vendor_type: @servicetype[j]["title"], service_type_id: @servicetype[j]["id"], commission: @data[i]["commission"], email: @data[i]["email"], auth_key: vendor_key)
      end
     end
 	 end
   end
  end

  def check_servicetype
    data, array, servicetype = [], [], []
    (0..@data.size-1).each do |i|
        data << @data[i]["servicetype"].mb_chars.capitalize.to_s
    end
    (0..@servicetype.size-1).each do |j|
        servicetype << @servicetype[j]["title"]
    end 

    array = data - servicetype
    array.uniq!
    if array != []
      (0..array.size-1).each do |a|
        PostRequest.non_utility_service_type(array[a])
    end
    else
      puts "----------No one new servicetype----------"
    end
  end

  def non_utility_service_type
    @servicetype.each do |type|
      PostRequest.non_utility_service_type(type["title"])
    end
  end

  def non_utility_vendor
    (0..@data.size-1).each do |i|
      geocode = GetRequest.geocode(@data[i]["address"])
      (0..@servicetype.size-1).each do |j|
        if @data[i]["servicetype"].mb_chars.capitalize.to_s == @servicetype[j]["title"]
          PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, "уточните по телефону", @data[i]["address"], @servicetype[j]["id"], geocode)
        end
      end
    end
  end

  def one_vendor
    PostRequest.non_utility_vendor_with_image(@data[33]["title"], @data[33]["phone"].to_i.to_s, "уточните по телефону", @data[33]["address"], 12, "http://cs320425.vk.me/v320425507/253f/yrWswddXZTY.jpg")
  end

  private

  def parsing_file(file)
    s = Roo::Excel.new(file)
    key, @data = [], []
    hash = {}
    key = ["title", "commission", "email", "phone", "address", "servicetype"]
      (2..s.last_row).each do |i|
        if s.cell(i, 2) == 2.0
          hash =  {key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11), key[5] => s.cell(i, 13) }
          @data << hash
        end
      end
    return @data
  end

  def servicetype
    servicetype, key, array = [], [], []
    hash = {}
    servicetype = GetRequest.servicetypes
    key = ["title", "id"]
    (0..servicetype.size-1).each do |i|
      hash =  {key[0] => servicetype[i]["non_utility_service_type"]["title"], key[1] => servicetype[i]["non_utility_service_type"]["id"] }
      array << hash
    end 
    return array
  end
end