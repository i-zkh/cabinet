class Txt
  def self.txt(vendor_id, month)
  @report = GetRequest.report_monthly(vendor_id, month)
  vendor = Vendor.where(id: vendor_id).first
    outFile = File.new("#{vendor.title}-#{month}.txt", "w")
      @report.each do |d|
          outFile.puts("#{d['user_account']};#{d['address']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
        end
      outFile.close
  end
end