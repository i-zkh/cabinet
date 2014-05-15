#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetypes = get_type("service_type")
    @non_utility_service_types = get_type("non_utility_service_type")
    @cities = cities
    @non_utility_vendors_contacts = non_utility_vendors_contacts(file)
  end

  def add_vendors
    (0..@data.size-1).each do |i|
      unless Vendor.where(title: @data[i]["title"]).first
        check_servicetype(@data[i]["servicetype"].mb_chars.capitalize.to_s)
        vendor_id = PostRequest.vendor(@data[i]["title"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], @data[i]["commission"].to_i, cities)
        vendor_id.parsed_response
        tariff_id = PostRequest.tariff_template(vendor_id["vendor"]["id"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s])
        tariff_id.parsed_response
        PostRequest.field_template(tariff_id["id"])
        v = Vendor.new(
              title:              @data[i]["title"],
              vendor_type:        @data[i]["servicetype"].mb_chars.capitalize.to_s, 
              service_type_id:    @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], 
              commission:         @data[i]["commission"], 
              email:              @data[i]["email"],
              auth_key:           Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)[0..5], 
              distribution:       @data[i]["email"] ? true : false
            )
        v.id = vendor_id["vendor"]["id"].to_i
        v.save!
      end
    end
  end

  def add_vendors_old_version
    (0..@data.size-1).each do |i|
      cities = []
      @data[i]["city"].split(',').each { |city_title| cities << { id: @cities["#{city_title}"] } }
      unless Vendor.where(title: @data[i]["title"]).first
        check_servicetype(@data[i]["servicetype"].mb_chars.capitalize.to_s)
        vendor_id = PostRequest.vendor(@data[i]["title"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], @data[i]["commission"].to_i, cities)
        vendor_id.parsed_response
        tariff_id = PostRequest.tariff_template(vendor_id["vendor"]["id"], @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s])
        tariff_id.parsed_response
        PostRequest.field_template(tariff_id["id"])
        v = Vendor.new(
              title:              @data[i]["title"],
              vendor_type:        @data[i]["servicetype"].mb_chars.capitalize.to_s, 
              service_type_id:    @servicetypes[@data[i]["servicetype"].mb_chars.capitalize.to_s], 
              commission:         @data[i]["commission"], 
              email:              @data[i]["email"], 
              auth_key:           Digest::MD5.hexdigest((0...5).map{('a'..'z').to_a[rand(26)]}.join)[0..5], 
              distribution:       @data[i]["email"] ? true : false
            )
        v.id = vendor_id["vendor"]["id"].to_i
        v.save!
        check_non_utility_service_types(@data[i]["servicetype"].mb_chars.capitalize.to_s)
        PostRequest.non_utility_vendor(
          @data[i]["title"], 
          @data[i]["phone"].to_i.to_s,
          @data[i]["work_time"] != nil ? @data[i]["work_time"] : "уточните по телефону", 
          @data[i]["address"], 
          @non_utility_service_types[@data[i]["servicetype"].mb_chars.capitalize.to_s], 
          GetRequest.geocode(@data[i]["address"])
        )  
      end
    end
      @non_utility_vendors_contacts.each {|contact| PostRequest.non_utility_vendors_contact(contact["vendor_id"], contact["title"], contact["phone"])}
  end

  # Add servicetypes and non_utility_service_types 
  def check_servicetype(title)
    if @servicetypes[title].nil?
      PostRequest.servicetype(title)
      @servicetypes = get_type("service_type")
    end
  end

  def check_non_utility_service_types(title)
    if @non_utility_service_types[title].nil?
      PostRequest.non_utility_service_type(title)
      @non_utility_service_types = get_type("non_utility_service_type")
    end
  end

  private

    def parsing_file(file) 
      s, key, data = Roo::Excelx.new(file), ["title", "commission", "email", "phone", "address", "servicetype", "work_time", "city"], []
      (2..s.last_row).each { |i| data << { key[0] => s.cell(i, 4), key[1] => s.cell(i, 7), key[2] => s.cell(i, 10), key[3] => s.cell(i, 8), key[4] => s.cell(i, 11), key[5] => s.cell(i, 13), key[6] => s.cell(i, 9), key[7] => s.cell(i, 5) } if s.cell(i, 2) == 2.0 }
      data
    end

    def non_utility_vendors_contacts(file)
      s, key, data, hash = Roo::Excelx.new(file), ["vendor_id", "title", "phone"], [], {}
      (2..s.last_row).each do |i|
          if s.cell(i, 2) == 2.0 && !s.cell(i, 14).nil?
            GetRequest.non_utility_vendors.each {|n_u_v| @non_utility_vendor_id = n_u_v["id"] if n_u_v["title"] == s.cell(i, 4)}
            (14..s.last_column-1).step(2).each { |j| data << { key[0] => @non_utility_vendor_id, key[1] => s.cell(i, j), key[2] => s.cell(i, j+1).to_i.to_s} if !s.cell(i, j).nil? }
          end
      end
      data
    end

    def get_type(type)
      servicetype, hash = [], {}
      servicetype = type == "service_type" ? GetRequest.servicetypes : GetRequest.nonutilityservicetype
      servicetype.each { |s| hash[s[type]["title"]] = s[type]["id"] }
      hash
    end

    def cities
      hash, cities = {}, GetRequest.cities
      cities.each { |c| hash[c["city"]["title"]] = c["city"]["id"] }
      hash
    end
end