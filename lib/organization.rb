#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetypes = type("service_type")
    @non_utility_service_types = type("non_utility_service_type")
    @cities = cities
  end

  def add_absence_vendor
    check_servicetypes
    check_non_utility_service_types

    (0..@data.size-1).each do |i|
      cities, array = [], []
      array =  @data[1]["city"].split(',')
      array.each do |city_title|
          cities << {id: @cities["#{city_title}"]}
      end
      geocode = GetRequest.geocode(@data[i]["address"])
      work_time = @data[i]["work_time"] != nil ? @data[i]["work_time"] : "уточните по телефону"
   	  vendor = Vendor.where(title: @data[i]["title"]).first
        unless vendor
          vendor_id = PostRequest.vendor(@data[i]["title"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], @data[i]["commission"].to_i, cities)
          vendor_id.parsed_response["vendor"]
          tariff_id = PostRequest.tariff_template(vendor_id["vendor"]["id"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s])
          tariff_id.parsed_response
          PostRequest.field_template(tariff_id["id"])
          vendor_key = Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)[0..5]
          ven = Vendor.new(title: @data[i]["title"], vendor_type: @data[i]["servicetype"].mb_chars.capitalize.to_s, service_type_id: @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], commission: @data[i]["commission"], email: @data[i]["email"], auth_key: vendor_key)
          ven.id = vendor_id["vendor"]["id"].to_i
          ven.save!
          PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], @non_utility_service_types[@data[i]["servicetype"].mb_chars.capitalize.to_s], geocode)
        end
      end
    end

  # Add servicetypes and non_utility_service_types


  def check_servicetypes
    servicetypes = get_servicetypes(@servicetypes)
    unless servicetypes.nil?
      (0..servicetypes.size-1).each do |s|
        PostRequest.servicetype(servicetypes[s])
      end
    end
  end

  def check_non_utility_service_types
    servicetypes = get_servicetypes(@non_utility_service_types)
    unless servicetypes.nil?
      (0..servicetypes.size-1).each do |s|
        PostRequest.non_utility_service_type(servicetypes[s])
      end
    end
  end

  # Not check! Add all non_utility vendors
  def non_utility_vendor
    (0..@data.size-1).each do |i|
      work_time = @data[i]["work_time"] != nil ? @data[i]["work_time"] : "уточните по телефону"
      PostRequest.non_utility_vendor_with_image(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], @non_utility_service_types[@data[i]["servicetype"].mb_chars.capitalize.to_s], "http://cs320425.vk.me/v320425507/253f/yrWswddXZTY.jpg") if @data[i]["title"] == "ООО \"Цифрал-Самара\"(Самара)"
      unless @data[i]["title"] == "ООО \"Цифрал-Самара\"(Самара)" 
        geocode = GetRequest.geocode(@data[i]["address"])
        PostRequest.non_utility_vendor(@data[i]["title"], @data[i]["phone"].to_i.to_s, work_time, @data[i]["address"], @non_utility_service_types[@data[i]["servicetype"].mb_chars.capitalize.to_s], geocode)
      end
    end
  end
  
  # Add commission
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
      key, @data, hash = ["title", "commission", "email", "phone", "address", "servicetype", "work_time", "city"], [], {}
      (2..s.last_row).each do |i|
          if s.cell(i, 2) == 2.0
            hash =  { key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11), key[5] => s.cell(i, 13), key[6] => s.cell(i, 9), key[7] => s.cell(i, 5) }
            @data << hash
          end
      end
      @data
    end

    def get_servicetypes(servicetypes)
      data, array = [], []
      @data.each { |d|  data << d["servicetype"].mb_chars.capitalize.to_s }
      array = data - servicetypes.keys
      array.uniq!
    end

    def type(type)
      servicetype, hash = [], {}
      servicetype = type == "service_type" ? GetRequest.servicetypes : GetRequest.nonutilityservicetype
      servicetype.each do |s|
        hash[s[type]["title"]] = s[type]["id"]
      end
      hash
    end

    def cities
      hash = {}
      cities = GetRequest.cities
      cities.each do |c| 
        hash[c["city"]["title"]] = c["city"]["id"]
      end
      hash
    end
end