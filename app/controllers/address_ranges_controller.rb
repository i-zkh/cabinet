class AddressRangesController < ApplicationController
  
   #Trashcan of XML

  def create
  #parsing_xlt("VOKU1.xls")
  #post_test(cyfral)
  #get_request_vendor(vendor_all)
  end
  

  def parsing_xlt(file_path)
   p s = Roo::Excel.new(file_path)
   row = Array.new
   data = Array.new
   value =[]
   hash = {}
   key = ["user_account"]

   (7..271).each do |i|
    row << s.cell(i,2)
   end

   row.each do |v|
    hash = { key[0] => v[0] }
       data << hash
   end
    data

#    create_data(data, s)
  end
    
  def parsing_xml(file_path)
   s = Roo::Excel.new(file_path)
   row = Array.new
   data = Array.new
   value =[]
   hash = {}
   key = ["user_account", "city", "area", "street", "house", "building", "apartment", "section", "invoice_amount"]

   (s.first_row..s.last_row).each do |i|
     row << s.cell(i,1).to_s.split(/;/)
   end

   row.each do |v|
    hash = { key[0] => v[0], key[1] => v[1], key[2] => v[2], key[3] => v[3], key[4] => v[4], key[5] => v[5], key[6] => v[6], key[7] => v[7], key[8] => v[8] }
       data << hash
   end
#    create_data(data, s)
    create_payload(data, s)
 end

def create_data(data, s)
  (0..s.last_row-1).each do |i|
    AddressRange.create!(city: data[i]["city"], area: data[i]["area"], street: data[i]["street"], house: data[i]["house"], building: data[i]["building"], apartment: data[i]["apartment"], section: data[i]["section"], vendor_id: 1, id: i)
    UserIdRange.create!(user_account: data[i]["user_account"], vendor_id: 1, id: i)

  end
end

def create_payload(data, s)
   i = 0
   #@first = UserIdRange.limit(65536)
   array = Array.new

   AddressRange.where('id > 65536').each do |u|
   array << u.id
 end

 array.each do |u_id|
 Payload.create!(user_id: u_id, user_type: "AddressRange", invoice_amount: data[i]["invoice_amount"], vendor_id: 1)
  i = i+1
    end
end

end