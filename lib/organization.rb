#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetypes = servicetypes
    @non_utility_service_types = non_utility_service_types
    @cities = GetRequest.cities
  end

  def add_absence_vendor
    
    check_non_utility_service_types
    # check_servicetypes

    # (0..@data.size-1).each do |i|
    # cities, array = {}, []


    # array =  @data[1]["city"].split(',')
    # array.each do |city|
    #   @cities.each do |city_id|
    #     if city_id["city"]["title"] == city
    #       cities["id"] = city_id["city"]["id"]
    #     end
    #   end
    # end
    # p cities
    # PostRequest.vendor(@data[1]["title"], @servicetypes[2]["id"], @data[1]["commission"].to_i, cities)

    # geocode = GetRequest.geocode(@data[i]["address"])
    # work_time = @data[i]["work_time"] != nil ? @data[i]["work_time"] : "уточните по телефону"
   	# vendor = Vendor.where(title: @data[i]["title"]).first
     #  unless vendor
     #        vendor_id = PostRequest.vendor(@data[i]["title"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], @data[i]["commission"].to_i)
     #        vendor_id.parsed_response["vendor"]
     #        tariff_id = PostRequest.tariff_template(vendor_id["vendor"]["id"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s])
     #        tariff_id.parsed_response
     #        PostRequest.field_template(tariff_id["id"])
     #        vendor_key = Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)[0..5]
     #        ven = Vendor.new(title: @data[i]["title"], vendor_type: @data[i]["servicetype"].mb_chars.capitalize.to_s, service_type_id: @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], commission: @data[i]["commission"], email: @data[i]["email"], auth_key: vendor_key)
     #        ven.id = vendor_id["vendor"]["id"].to_i
     #        ven.save!
     #        PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], @non_utility_service_types[@data[i]["servicetype"].mb_chars.capitalize.to_s], geocode)
     #  end
    # end
  end

  def check_non_utility_service_types
    data, array, servicetype = [], [], []
    @data.each { |d|  print d }
    
    # (0..@non_utility_service_types.size-1).each do |j|
    #     servicetype << @non_utility_service_types[j]["title"]
    # end 
    # array = data - servicetype
    # array.uniq!
    # if array != []
    #   (0..array.size-1).each do |a|
    #     # PostRequest.non_utility_service_type(array[a])
    #   end
    # else
    #   puts "----------No one new non_utility_service_type----------"
    # end
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
        PostRequest.servicetype(array[a])
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
      work_time = @data[i]["work_time"] != nil ? @data[i]["work_time"] : "уточните по телефону"
      if @data[i]["title"] == "ООО \"Цифрал-Самара\"(Самара)"
        PostRequest.non_utility_vendor_with_image(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], 12, "http://cs320425.vk.me/v320425507/253f/yrWswddXZTY.jpg")
      end
      if @data[i]["title"] != "ООО \"Цифрал-Самара\"(Самара)" 
        geocode = GetRequest.geocode(@data[i]["address"])
        (0..@non_utility_service_types.size-1).each do |j|
          if @data[i]["servicetype"].mb_chars.capitalize.to_s == @non_utility_service_types[j]["title"]
            PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], @non_utility_service_types[j]["id"], geocode)
          end
        end
      end
    end
  end

  def get_data_to_vendor
    (0..@data.size-1).each do |i|
      vendor = Vendor.where(title: @data[i]["title"]).first
      if vendor
      vendor.commission = @data[i]["commission"]
      vendor.save!
      end
    end
  end

  private

  def parsing_file(file)
    s = Roo::Excel.new(file)
    key, @data = ["title", "commission", "email", "phone", "address", "servicetype", "work_time", "city"], []
    hash = {}
    (2..s.last_row).each do |i|
        if s.cell(i, 2) == 2.0
          hash =  { key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11), key[5] => s.cell(i, 13), key[6] => s.cell(i, 9), key[7] => s.cell(i, 5) }
          @data << hash
        end
    end
    @data
  end

  def servicetypes
    servicetype, hash = [], {}
    servicetype = GetRequest.servicetypes
    (0..servicetype.size-1).each do |i|
      hash[servicetype[i]["service_type"]["title"]] = servicetype[i]["service_type"]["id"]
    end
    p hash
  end

  def non_utility_service_types
    servicetype, hash = [], {}
    servicetype = GetRequest.nonutilityservicetype
    key = ["title", "id"]
    (0..servicetype.size-1).each do |i|
      hash[servicetype[i]["non_utility_service_type"]["title"]] =  servicetype[i]["non_utility_service_type"]["id"]
    end 
    p hash
  end
end