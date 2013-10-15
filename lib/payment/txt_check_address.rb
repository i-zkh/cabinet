class TxtCheckAddress < Payment
  attr_accessor :data, :id

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    i = 0
    outFile = File.new("#{Vendor.find(@id).title}.txt", "w")
      @data.each do |d|
        address = Account.where(user_account: d['user_account'], vendor_id: d['vendor_id']).first
            if address != nil
              outFile.puts("#{d['user_account']};#{address['city']}, #{address['street']}, #{address['building']}, #{address['apartment']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%d.%m.%Y")}")
            end
        end
    outFile.close
  end
end