class KeyController < ApplicationController
  def create	
	array, data, row = [], [], []
	hash = {}
	key = ["title", "service_type_id", "auth_key"]

	File.open("vendor.txt").each do |r|
		row << r
	end
	row.each do |num|
		array = num.split(";")
		k = (0...5).map{ ('a'..'z').to_a[rand(26)] }.join
		vendor_key = Digest::MD5.hexdigest(k)
 		hash = { key[0] => array[1], key[1] => array[2].to_i, key[2] => vendor_key}
		data << hash
	end
	(0..data.size-1).each do |i|
		#	Vendor.create!(title: data[i]["title"], auth_key: data[i]["auth_key"], service_type_id: data[i]["service_type_id"])
		end
    end
end
