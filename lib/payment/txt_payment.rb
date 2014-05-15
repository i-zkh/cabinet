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
      @data.each do |d| 
        d = d.split(';')
        outFile.puts("#{d[1]};#{d[2]};#{d[3]};#{d[7]}")
      end
    outFile.close
    filename
  end
end