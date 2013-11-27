#encoding: utf-8
class PaymentsController < ApplicationController
  	def create
    	vendors_id, @report, @data, error = [], [], [], []
		@report = GetRequest.report_daily
	    if @report != []
			Report.new(AllPayment.new(@report)).output_report
			Report.new(Booker.new(@report)).output_report
			Report.new(Error.new(@report)).output_report

	      @report.each do |report|
	      	vendors_id << report['vendor_id']
	      end
	      vendors_id.uniq.each do |id|
	      	@data = @report.select { |d| d['vendor_id'] == id.to_i }
	      	vendor = Vendor.where(id: id, distribution: true).first
	      	if vendor
		        case id
		    	when 5, 44, 40
		          	Report.new(TxtCheckAddress.new(@data, id)).output_report
		        else
		          	Report.new(TxtPayment.new(@data, id)).output_report
		        end
		   		ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	   		end
	      end
	    else
	   		ReportMail.no_transactions.deliver
	    end
    	render json: @report
  	end

  	def send_report
   		vendors_id, @report, @data = [], [], []
		@report = params[:report]
	    if @report != []
	    	Report.new(AllPayment.new(@report)).output_report
			Report.new(Booker.new(@report)).output_report
			Report.new(Error.new(@report)).output_report
			# send_report_to_vendors(@report)
	    end
	    render json: @report
  	end

	def monthly_xls
		vendors_id = GetRequest.report_vendors(10)
		vendors_id.each do |id|
			vendor = Vendor.where(id: id).first
			unless vendor.nil?
				p @report = GetRequest.report_monthly(id, DateTime.now.month)
				# Report.new(ReportMonthly.new(@report, id)).monthly
				# ReportMail.report_monthly("Выгрузка транзакций АйЖКХ за октябрь}", vendor).deliver unless File.zero?("report_monthly/10-2013/#{vendor.title.gsub!(/"/, "")}.xls")
			end
		end
	end

  	def self.monthly_txt(vendor_id, month)
	 	@report = GetRequest.report_monthly(vendor_id, month)
	  	vendor = Vendor.where(id: vendor_id).first
	    outFile = File.new("#{vendor.title}-#{month}.txt", "w")
	    	@report.each do |d|
	        	outFile.puts("#{vendor.title}	#{d['user_account']};#{d['address']};#{d['amount']};#{ DateTime.parse(d['date']).strftime("%Y-%m-%d")}")
	        end
	    outFile.close
  	end

  	private

  	def send_report_to_vendors(report)
	    report.each { |r| vendors_id << r['vendor_id'] }
	    vendors_id.uniq.each do |id|
	      	@data = report.select { |d| d['vendor_id'] == id.to_i }
	      	vendor = Vendor.where(id: id, distribution: true).first
	      	if vendor
		        case id
		    	when 5, 44, 40
		          	Report.new(TxtCheckAddress.new(@data, id)).output_report
		        else
		          	Report.new(TxtPayment.new(@data, id)).output_report
		        end
		        logger.info "transaction: #{vendor.title}-#{@data}"
		   		# ReportMail.report("Выгрузка транзакций АйЖКХ за #{Russian::strftime(DateTime.now, "%B " "%Y")}", vendor).deliver unless File.zero?("#{vendor.title}.txt")
	   		end
	    end
  	end

end