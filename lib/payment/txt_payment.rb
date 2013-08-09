class TxtPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    vendors_id = []
    report = []

    @data.each do |data| 
      vendors_id << data['vendor_id']
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
    return vendors_id
  end
end