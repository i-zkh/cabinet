#encoding: utf-8
class TxtPayment < Payment
  attr_accessor :data, :id

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    filename = "#{Vendor.where(id: @id).first.title}.txt"
    outFile = File.new(filename, "w")
      @data.each { |d| outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{DateTime.parse(d['date']).strftime("%d.%m.%Y")}") }
    outFile.close
    filename
  end
end