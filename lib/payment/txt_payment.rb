class TxtPayment < Payment
  attr_accessor :data, :id

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    outFile = File.new("#{Vendor.find(@id).title}.txt", "w")
      @data.each { |d| outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%d.%m.%Y")}") }
    outFile.close
  end
end