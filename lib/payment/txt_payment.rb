class TxtPayment < Payment
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def output
    i = 1
    outFile = File.new("out.txt", "w")
      @data.each do |d| 
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