class Mailer 

	def initialize(report)
		@report = report
	end

	def self.report
	    vendors_id, @report, @data, error = [], [], [], []
	    if @report != []
	      @report.each do |report|
	        vendors_id << report['vendor_id']
	        vendor = UserIdRange.where(user_account: @report['user_account'], vendor_id: @report['vendor_id'])
	          if vendor = ""
	              error << data
	          end
	      end
	      vendors_id.uniq!
	      vendor_id.each do |id|
	        case id
	        when 1..50
	          @data = @report.select { |d| d['vendor_id'] == id.to_i}
	          Report.new(TxtPayment.new(@data)).output_report
	          vendor = Vendor.where(id: id, distribution: true).first
	          ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	        else
	        end
	      end
	    end
	    accountFile = File.new("error.txt", "w")
	    accountFile.write(error)
	    accountFile.close
	    ReportMail.accounts.deliver
	end
end