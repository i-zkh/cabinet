class TxtPayment < Payment
  attr_accessor :data, :id

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    outFile = File.new("#{Vendor.find(@id).title}.txt", "w")
      @data.each do |d|
        address = UserIdRange.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
           if address != nil
              outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
           end
        end
    outFile.close
  end
end