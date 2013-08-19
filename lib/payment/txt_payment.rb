class TxtPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    vendors_id = []
    report = []
    absence_user_account = []
  if @data != []
    @data.each do |data| 
      vendors_id << data['vendor_id']
      vendor = UserIdRange.where(user_account: data['user_account'], vendor_id: data['vendor_id'])
      if vendor = ""
          absence_user_account << data
      else 
      end

    vendors_id.uniq!
    vendors_id.each do |v|
      report = @data.select { |d| d['vendor_id'] == v.to_i}
      i = 1
      outFile = File.new("#{Vendor.find(v).title}.txt", "w")
      report.each do |d|
        d.each_value do |value|
          outFile.write(value)
            if (i < d.size)
              outFile.write(";")
              i += 1
            end
        end
          i = 1
      outFile.puts
      end
      outFile.close
    end
  end
end
  accountFile = File.new("absence_user_account.txt", "w")
  accountFile.write(absence_user_account)
  accountFile.close

  return vendors_id
  end
end