#!/usr/bin/env
class CheckEmail 

	def self.check
		Mail.defaults do
		  retriever_method :pop3, :address    => "mail.nic.ru",
		                          :port       => 110,
		                          :user_name  => "out@izkh.ru",
		                          :password   => "EbabZas0",
		                          :enable_ssl => false
		end
		emails = Mail.all

		emails.each do |email|
			if email.date.strftime("%Y-%m-%d") == DateTime.now.strftime("%Y-%m-%d")
				vendor = Vendor.where(email: email.from[0]).first
				if vendor
					email.attachments.each do | attachment |
			    		filename = attachment.filename
			    		filename =~ /(\w+).(\w+)/
					    begin
					    	unless File.exist?("report/#{DateTime.now.month}-#{DateTime.now.year}/#{vendor.title}.#{$2}")
					      		File.open( "report/#{DateTime.now.month}-#{DateTime.now.year}/" + "#{vendor.title}.#{$2}", "w+b", 0644) {|f| f.write attachment.body.decoded} 
					      	else
					      		error = "Message from #{vendor.title} at #{email.date}"
								ReportMail.error(error, "[ERROR] Report from #{vendor.title}.#{$2} have been received").deliver unless error.empty?
					      	end
					    rescue Exception => e
					    	error = "Unable to save data for #{filename} because #{e.message}"
							ReportMail.error(error, "[ERROR] file don't create").deliver unless error.empty?
					    end
					end
				end
			end
		end
	end
end