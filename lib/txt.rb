class Txt

  def self.txt
      response = HTTParty.get( "https://izkh.ru/api/1.0/report_monthly?vendor_id=16&month=8&auth_token=#{Auth.get}")
      p @report = response.parsed_response["payment_history"]
 i = 1
  outFile = File.new("TXT.txt", "w")
      @report.each do |d|
        p d
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