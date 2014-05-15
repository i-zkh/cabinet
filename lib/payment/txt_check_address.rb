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
        d = d.split(';')
        address = Account.where(user_account: d[1], vendor_id: d[-1]).first
        if address.nil?
          outFile.puts("#{d[1]};#{d[2]};#{d[3]};#{d[7]}")
        else
          p outFile.puts("#{d[1]};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d[3]};#{d[7]}")
        end
      end
    outFile.close
    filename
  end
end