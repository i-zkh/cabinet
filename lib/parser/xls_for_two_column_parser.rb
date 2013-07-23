#encoding: UTF-8
class XlsForTwoColumnParser < Parser

  def initialize(file, vendor_id)
    @file = file
    @vendor_id = vendor_id
  end

  def input
   s = Roo::Excel.new(@file)

	key = Array.new 
	data = Array.new 
	hash = Hash.new 

	key = ["user_account", "invoice_amount"]

	for i in 2..s.last_row
	 hash =  {key[0] => s.cell(i, 1), key[1] => s.cell(i, 2)}
	  data << hash
	end

	#(0..data.size-1).each do |i|
    #		UserIdRange.create!(user_account: data[i]["user_account"], vendor_id: @vendor_id)
	#	end
	#	i = 0
    #	ActiveRecord::Base.connection.select_values('SELECT id FROM user_id_ranges WHERE id > 213845').each do |u_id|
 	#		Payload.create!(user_id: u_id, user_type: "UserIdRange", invoice_amount: data[i]["invoice_amount"], vendor_id: @vendor_id)
 	#		i += 1
    #	end
  end
end