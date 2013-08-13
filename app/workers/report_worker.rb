class ReportWorker
  include Sidekiq::Worker
     def perform
		vendor = []
        if session[:auth_token] = ""
          response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
          :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
          :headers => { 'Content-Type' => 'application/json' })
          @user = response.parsed_response["user"]["auth_token"]
          session[:auth_token] = @user
        end
        auth = session[:auth_token]
	    request = RequestPayment.new(auth)
	    report = Report.new(TxtPayment.new(request.get_payment))
	    vendor_id = report.output_report
	    vendor_id.each do |v|
	    	vendor = Vendor.find(v)
	    	ReportMail.report("report", vendor).deliver
	    end
    end
end
