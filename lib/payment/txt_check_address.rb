#encoding: utf-8
class TxtCheckAddress < Payment
  attr_accessor :data, :id

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    filename = "#{Vendor.where(id: @id).first.title}.txt"
    outFile = File.new(filename, "w")
      @data.each do |d|
        address = Account.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
        data = d['date'].nil? ? DateTime.parse(d['created_at']).strftime("%d.%m.%Y") : DateTime.parse(d['date']).strftime("%d.%m.%Y")
        if address.nil?
          outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{data}")
        else
          outFile.puts("#{d['user_account']};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d['amount']};#{data}")
        end
      end
    outFile.close
    filename
  end
end