#encoding: utf-8
require 'russian'
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
	    	ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver
	    end
    end
end
