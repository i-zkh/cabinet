class ManagerController < ApplicationController
  def index
  # p params[:month]
  # p @list = File.basename("report/#{DateTime.now.year}-#{DateTime.now.month}/#{v.title}", ".*")
  @vendors = Vendor.all.select{ |v| p !File.exists?(File.basename("report/#{DateTime.now.year}-#{DateTime.now.month}/#{v.title}", ".*")) }
  p @list = vendors_with_report
  end

  def import
    @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
    spreadsheet = open_spreadsheet(params[:file])
  	redirect_to manager_report_url
  end

	def open_spreadsheet(file)
		FileUtils.mkpath "report/#{DateTime.now.year}-#{DateTime.now.month}"
    filename = "report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{Vendor.where(id: params[:vendor]).first.title}" + "#{File.extname("#{file.original_filename}")}"
		File.open(File.join(filename), "wb") { |f| f.write(file.read) }
    begin
  	  case File.extname(file.original_filename)
  	  when ".TXT"  then Getter.new(Txt.new(filename, params[:vendor])).input
  	  when ".txt"  then Getter.new(Txt.new(filename, params[:vendor])).input
  	  when ".xls"  then Getter.new(Xls.new(filename, params[:vendor])).input
  	  when ".xlsx" then Getter.new(Xls.new(filename, params[:vendor])).input
      when ".DBF"  then Getter.new(Dbf.new(filename, params[:vendor])).input
      when ".ods"  then Getter.new(Ods.new(filename, params[:vendor])).input
  	  else
        ReportMail.error("Unknown file type: filename", "[ERROR] report").deliver
  	  end
    rescue Exception => e
        ReportMail.error("Unable to save data from #{filename} because #{e.message}. Ip address: #{request.remote_ip}.", "[ERROR] report").deliver
    end
	end

  def vendors_with_report
    # vendors_with_report = []
    # Dir.foreach('report/#{DateTime.now.year}-#{DateTime.now.month}') do |file|
    #   next if file == '.' or file == '..'
    #   p file
    #   # vendors_with_report << Vendor.where(title: File.basename("file", ".*").first)
    # end
  end
end