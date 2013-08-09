class ReportWorker
  include Sidekiq::Worker
     def perform
		vendor = []
	  	auth = "LuNXcS4tAGMgj8xwr7LR"
	    request = RequestPayment.new(auth)
	    report = Report.new(TxtPayment.new(request.get_payment))
	    vendor_id = report.output_report
	    vendor_id.each do |v|
	    	vendor = Vendor.find(v)
	    	ReportMail.report("report", vendor).deliver
	    end
     end
end
