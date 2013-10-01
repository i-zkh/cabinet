#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetypes = servicetypes
    @non_utility_service_types = non_utility_service_types
  end

  def add_absence_vendor
    check_non_utility_service_types
    check_servicetypes
    #  geocode = GetRequest.geocode(@data[i]["address"])
 		  vendor = Vendor.where(title: @data[i]["title"]).first
     	unless vendor
        (0..@servicetypes.size-1).each do |j|
          if @servicetypes[j]["title"].mb_chars.downcase.to_s == @data[i]["servicetype"]
          # PostRequest.vendor(@data[i]["title"], @servicetypes[j]["id"])
          # vendor_key = Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)[0..5]
           p @data[i]["title"]
          # Vendor.create!(title: @data[i]["title"], vendor_type: @servicetypes[j]["title"], service_type_id: @servicetypes[j]["id"], commission: @data[i]["commission"], email: @data[i]["email"], auth_key: vendor_key)
          end
        end
     	  (0..@non_utility_service_types.size-1).each do |j|
          if @non_utility_service_types[j]["title"].mb_chars.downcase.to_s == @data[i]["servicetype"]
             p @data[i]["title"]
            #PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, "уточните по телефону", @data[i]["address"], @non_utility_service_types[j]["id"], geocode)
          end
        end
   	  end
    end
  end

  def check_non_utility_service_types
    data, array, servicetype = [], [], []
    (0..@data.size-1).each do |i|
        data << @data[i]["servicetype"].mb_chars.capitalize.to_s
    end
    (0..@non_utility_service_types.size-1).each do |j|
        servicetype << @non_utility_service_types[j]["title"]
    end 
    array = data - servicetype
    array.uniq!
    if array != []
      (0..array.size-1).each do |a|
        p array[a]
        # PostRequest.non_utility_service_type(array[a])
      end
    else
      puts "----------No one new non_utility_service_type----------"
    end
  end

  def check_servicetypes
    data, array, servicetype = [], [], []
    (0..@data.size-1).each do |i|
        data << @data[i]["servicetype"].mb_chars.capitalize.to_s
    end
    (0..@servicetypes.size-1).each do |j|
        servicetype << @servicetypes[j]["title"]
    end 
    array = data - servicetype
    array.uniq!
    if array != []
      (0..array.size-1).each do |a|
        p array[a]
        # PostRequest.servicetype(array[a])
      end
    else
      puts "----------No one new servicetype----------"
    end
  end

  #Add all data from file
  def non_utility_service_type
    @servicetype.each do |type|
      PostRequest.non_utility_service_type(type["title"])
    end
  end

  def non_utility_vendor
    (0..@data.size-1).each do |i|
      p @data[i]["title"]
      if @data[i]["title"] == "ООО \"Цифрал-Самара\"(Самара)"
        PostRequest.non_utility_vendor_with_image(@data[i]["title"], @data[i]["phone"].to_i.to_s, "уточните по телефону", @data[i]["address"], 12, "http://cs320425.vk.me/v320425507/253f/yrWswddXZTY.jpg")
      end
      if @data[i]["title"] != "ООО \"Цифрал-Самара\"(Самара)" 
        geocode = GetRequest.geocode(@data[i]["address"])
        (0..@servicetype.size-1).each do |j|
          if @data[i]["servicetype"].mb_chars.capitalize.to_s == @servicetype[j]["title"]
            PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, "уточните по телефону", @data[i]["address"], @servicetype[j]["id"], geocode)
         end
        end
      end
    end
  end

  def get_data_to_vendor
    (0..@data.size-1).each do |i|
      vendor = Vendor.where(title: @data[i]["title"]).first
      if vendor
      vendor.email = @data[i]["email"]
      vendor.save!
      end
    end
  end

  private

  def parsing_file(file)
    s = Roo::Excel.new(file)
    key, @data = ["title", "commission", "email", "phone", "address", "servicetype"], []
    hash = {}
    (2..s.last_row).each do |i|
        if s.cell(i, 2) == 2.0
          hash =  {key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11), key[5] => s.cell(i, 13) }
          @data << hash
        end
    end
    @data
  end

  def servicetypes
    servicetype, key, array = [], [], []
    hash = {}
    servicetype = GetRequest.servicetypes
    key = ["title", "id"]
    (0..servicetype.size-1).each do |i|
      hash =  {key[0] => servicetype[i]["service_type"]["title"], key[1] => servicetype[i]["service_type"]["id"] }
      array << hash
    end 
    array
  end

  def non_utility_service_types
    servicetype, key, array = [], [], []
    hash = {}
    servicetype = GetRequest.nonutilityservicetype
    key = ["title", "id"]
    (0..servicetype.size-1).each do |i|
      hash =  {key[0] => servicetype[i]["non_utility_service_type"]["title"], key[1] => servicetype[i]["non_utility_service_type"]["id"] }
      array << hash
    end 
    array
  end
end