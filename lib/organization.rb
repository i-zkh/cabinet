#encoding: utf-8
require 'russian'
require 'open-uri'
class Organization
	
  def initialize(file)
    @data = parsing_file(file)
    @servicetype = servicetype
  end

  def add_absence_vendor
 #   check_servicetype
 #	(0..@data.size-1).each do |i|
 #		vendor = Vendor.where(title: @data[i]["title"]).first
 #		if !vendor
 #	   (0..@servicetype.size-1).each do |j|
 #      if @servicetype[j]["title"].mb_chars.downcase.to_s == @data[i]["servicetype"]
 #      #CREATE VENDOR 
 #         vendor = AddVendorToService.new(@data[i]["title"], @servicetype[j]["id"])
 #         vendor.add

 #      k = (0...5).map{('a'..'z').to_a[rand(26)]}.join
 #      vendor_key = Digest::MD5.hexdigest(k)
 #        Vendor.create!(title: @data[i]["title"], vendor_type: @servicetype[j]["title"], service_type_id: @servicetype[j]["id"], commission: @data[i]["commission"], email: @data[i]["email"], auth_key: vendor_key)
 #      end
 #    end
 #	 end
 #  end
  end

  def check_servicetype
    data = []
    servicetype = []
    array = []

    (0..@data.size-1).each do |i|
        data << @data[i]["servicetype"].mb_chars.capitalize.to_s
    end 
    (0..@servicetype.size-1).each do |j|
        servicetype << @servicetype[j]["title"]
    end 

    array = data - servicetype
    if array != []
      (0..array.size-1).each do |a|
      #  AddServicetypeToService.new(array[a]).add
    end
    else
      puts "----------No one new servicetype----------"
    end
  end

  def type_create
    type = []
    type = servicetype
    type.each do |type|
      response = HTTParty.post( "https://izkh.ru/api/1.0/nonutilityservicetype?auth_token=#{Auth.get}",
        :body => { :non_utility_service_type =>  { :title => type["title"] }}.to_json,
        :headers => { 'Content-Type' => 'application/json' })
    end
  end

  def non_utility_vendor_create
    (0..@data.size-1).each do |i|
      response = HTTParty.get( URI::encode("http://geocode-maps.yandex.ru/1.x/?geocode=#{@data[i]["address"]}&format=json") )
      geocode = response["response"]["GeoObjectCollection"]["featureMember"].first["GeoObject"]["Point"]["pos"].gsub!(" ", ",")
      (0..@servicetype.size-1).each do |j|
        if @data[i]["servicetype"].mb_chars.capitalize.to_s == @servicetype[j]["title"]
          response = HTTParty.post( "https://izkh.ru/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
            :body => { :non_utility_vendor =>  { title: @data[i]["title"], phone: @data[i]["phone"].to_i.to_s, work_time: "уточните по телефону", address: @data[i]["address"], non_utility_service_type_id: @servicetype[j]["id"] },
            :picture => { url: "http://static-maps.yandex.ru/1.x/?ll=#{geocode}&z=15&l=map&size=300,200&pt=#{geocode}"}}.to_json,
            :headers => { 'Content-Type' => 'application/json' })
        end
      end
    end
  end

  private

  def parsing_file(file)
    s = Roo::Excel.new(file)
    key = Array.new 
    @data = Array.new 
    hash = Hash.new 

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
    servicetype = []
    key = Array.new 
    array = Array.new 
    hash = Hash.new 
    servicetype = GetRequest.servicetypes
    key = ["title", "id"]
      (0..servicetype.size-1).each do |i|
          hash =  {key[0] => servicetype[i]["non_utility_service_type"]["title"], key[1] => servicetype[i]["non_utility_service_type"]["id"] }
          array << hash
      end 
      return array
  end
end