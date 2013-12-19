#!/usr/bin/env
class CheckEmail

	# Automatically receive reports from out@izkh.ru.
	#
	# * Report from vendors. Get report's content: user_account, user_amount for the current month. Some organizations add user's address.
	#  	This date need to update user_amount in service every month and check transactions.
	# 
	# 	Take messages from last month and finds date from vendor's email.
	# 	Report add in folder report/#{DateTime.now.month}-#{DateTime.now.year}/#{filename}. Filename substituted on vendors's title.
	## 	Report parsing and add in baza. 
	#   
	# 	Error. Message with error will send on out@izkh.ru in this situations:
	## 	- app haven't parser for this report
	# 	- app have report from this vendor already
	#   - app can't save this message

	def self.get_reports
		Mail.defaults do
		  retriever_method :pop3, :address    => "mail.nic.ru",
		                          :port       => 110,
		                          :user_name  => "system@izkh.ru",
		                          :password   => "FikyMoz1",
		                          :enable_ssl => false
		end
		p emails = Mail.all

		emails.each do |email|
			if email.date.strftime("%Y-%m-%d") == "#{DateTime.now.strftime("%Y-%m-%d")}"
				vendor = Vendor.where(email: email.from[0]).first
				if vendor
					p email
					email.attachments.each do |attachment|
			    		filename = attachment.filename
			    		filename =~ /(\w+).(\w+)/
			    		p $2
					    begin
					    	if !File.exist?("report/#{DateTime.now.month}-#{DateTime.now.year}/#{filename}")
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

	# * Report "Organizations" from managers. Get vendor's attributes: title, city, region, commission, phone, time of work, email, address, meneger, type of organozation. 
	#  	This date need to add new vendors in service and vendor's handbook.
	# 	
	# 	Take daily messages and finds date with subject "organozations".
	# 	Report add in folder organizations/#{filename}. Filename substituted on #{DateTime.now.strftime("%m-%d")}-#{filename} like "12-13-Organizations.xls".
	# 	Report parsing, new vendor add in service, baza and handbook. 
	#   
	# 	Error. Message with error will send on out@izkh.ru in this situations:
	# 	- app can't save this message

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