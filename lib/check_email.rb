#!/usr/bin/env
class CheckEmail 

	def self.get_reports
		Mail.defaults do
		  retriever_method :pop3, :address    => "mail.nic.ru",
		                          :port       => 110,
		                          :user_name  => "system@izkh.ru",
		                          :password   => "FikyMoz1",
		                          :enable_ssl => false
		end
		emails = Mail.all

		emails.each do |email|
			p email
			if email.date.strftime("%Y-%m-%d") == DateTime.now.strftime("%Y-%m-%d")
				vendor = Vendor.where(email: email.from[0]).first
				if vendor
					email.attachments.each do |attachment|
			    		filename = attachment.filename
			    		filename =~ /(\w+).(\w+)/
					    begin
					    	unless File.exist?("report/#{DateTime.now.month}-#{DateTime.now.year}/#{vendor.title}.#{$2}")
					      		File.open( "report/#{DateTime.now.month}-#{DateTime.now.year}/" + "#{vendor.title}.#{$2}", "w+b", 0644) {|f| f.write attachment.body.decoded} 
					      	else
					      		error = "Message from #{vendor.title} at #{email.date}"
								ReportMail.error(error, "[ERROR] Report have been received").deliver
					      	end
					    rescue Exception => e
					    	error = "Unable to save data for #{filename} because #{e.message}"
							ReportMail.error(error, "[ERROR] file don't create").deliver
					    end
					end
				end
			end
		end
	end

	def self.get_organizations
		Mail.defaults do
		  retriever_method :pop3, :address    => "mail.nic.ru",
		                          :port       => 110,
		                          :user_name  => "ivanova@izkh.ru",
		                          :password   => "view9Rax",
		                          :enable_ssl => false
		end
		emails = Mail.all

		emails.each do |email|
			if email.date.strftime("%Y-%m-%d") == "#{DateTime.now.strftime("%Y-%m-%d")}"
				if email.subject.chomp == "Organizations"
					email.attachments.each do |attachment|
			    		filename = attachment.filename
					    begin
					      	File.open( "organizations/" + "#{DateTime.now.strftime("%m-%d")}-#{filename}", "w+b", 0644) {|f| f.write attachment.body.decoded}
					    rescue Exception => e
					    	error = "Unable to save file #{filename} because #{e.message}"
							ReportMail.error(error, "[ERROR] Organizations").deliver
					    end
					end
				end
			end
		end
	end
end