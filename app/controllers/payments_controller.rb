#encoding: utf-8
class PaymentsController < ApplicationController

	# Daily report for managers
	def xls_report_daily
		@report = GetRequest.report_daily
	end

	def xls
		Report.new(ReportForManager.new(GetRequest.report_daily)).output_report
		send_file 'transactions.xls'
	end

	def report_with_gibbon
		gb = Gibbon::API.new("df5b5ea75168dc2f5d3d105aefbd807a-us3")

	  	list_id = "592b42a4a7"

			gb.lists.subscribe({:id => list_id, 
	    	:email => {
	    		:email => "out@izkh.ru" }, 
	    		:merge_vars => {:FNAME => 'Nastya Ivanova', 
	    			:LNAME => ''
	    			}, 
	    			:double_optin => false})

		render json: true
	end

	def new_report
		gb = Gibbon::API.new("df5b5ea75168dc2f5d3d105aefbd807a-us3")
		list_id = "592b42a4a7"

		cid = gb.campaigns.create({
				type: "regular", 
				options: { list_id: list_id, 
	    					subject: "АйЖКХ",
	    					from_email: "out@izkh.ru",
	    					from_name: "Сервис АйЖКХ",
	    					generate_text: true
	    				 },
		    	content: {archive: "mail.zip"
		    	}
	    })
 
    	gb.campaigns.send(cid: cid['id'])
    	# gb.campaigns.schedule(cid: cid['id'], schedule_time: "2014-02-06 20:30:00")

		render json: true
	end

  	# Daily report and errors to out@izkh.ru
    def create
		@report = GetRequest.report_daily_for_vendor
	    if @report != []
	    	send_report_to_vendors(@report)
			# Report.new(AllPayment.new(@report)).output_report
			# Report.new(Error.new(@report)).output_report
	    else
	   		ReportMail.no_transactions.deliver
	    end
	    render json: @report
    end

	def monthly_xls
		GetRequest.report_monthly(1).each do |id|
			Report.new(ReportMonthly.new(GetRequest.transactions(id, 1), id)).monthly
			vendor = Vendor.where(id: id, distribution: true).first
			unless vendor.nil?
				ReportMail.report_monthly("Выгрузка транзакций АйЖКХ за январь}", vendor).deliver if id != 5 || id != 40 || id != 41 || id != 159 || id !=135 || id != 107
			end
		end	
		render json: true
	end

  	def monthly_txt
		GetRequest.report_monthly(2).each do |id|
			if id = 121 #id == 43 || id == 44 id == 5 || id == 40 || id == 41 || id == 146 
				vendor = Vendor.where(id: id).first
				unless vendor.nil?
	 				@report = GetRequest.transactions(id, 2)
	    			Report.new(ReportMonthlyTxt.new(@report, id)).monthly
				end
			end
		end
	    render json: true
  	end

  	def hourly
		@report = GetRequest.report_hourly
	    if @report != []
			Report.new(Booker.new(@report)).output_report
			# send_report_to_vendors(@report)
    	end
    	render json: true
  	end

  	private

	def send_report_to_vendors(report)
  		vendors_id = []
	    report.each { |r| vendors_id << r['vendor_id'] }
	    vendors_id.uniq.each do |id|
	      	@data = report.select { |d| d['vendor_id'] == id.to_i }
	      	vendor = Vendor.where(id: id, distribution: true).first
	      	if vendor
		        case id
		    	when 5, 44, 40
		          	Report.new(TxtCheckAddress.new(@data, id)).output_report
		        when 150
		        	Report.new(Factorial.new(@data, id)).output_report
		        else
		          	Report.new(TxtPayment.new(@data, id)).output_report
		        end
		   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("transactions/#{DateTime.now.year}-#{DateTime.now.month}-#{DateTime.now.day}-#{id}.txt")
	    	end
	    end
  	end
end