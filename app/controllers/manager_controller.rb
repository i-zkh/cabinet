# coding: utf-8
class ManagerController < ApplicationController
  def index
    @vendors_with_report = vendors_with_report
    @vendors = Vendor.all - @vendors_with_report
    @month   = params.has_key?(:date) ? params[:date][:month].to_i : Date.today
    @year    = params.has_key?(:date) ? params[:date][:year].to_i  : Date.today 
  end

  # def create
  # p @vendors_with_report = vendors_with_report
  # @vendors = Vendor.all - @vendors_with_report
  # respond_to { |f| f.js { render "manager/create" }}
  # end

  def import
    @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
    spreadsheet = open_spreadsheet(params[:file])
  	redirect_to manager_report_url
  end

	def open_spreadsheet(file)
    FileUtils.mkpath "report/#{DateTime.now.year}-#{DateTime.now.month}"
    filename = "report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{Vendor.where(id: params[:vendor][:vendor_id]).first.title}" + "#{File.extname("#{file.original_filename}")}"
    File.open(File.join(filename), "wb") { |f| f.write(file.read) }
    begin
      case File.extname(file.original_filename).downcase
      when ".txt" then Getter.new(Txt.new(filename, params[:vendor])).input
      when ".xls", ".xlsx"  then Getter.new(Xls.new(filename, params[:vendor])).input
      when ".dbf" then Getter.new(Dbf.new(filename, params[:vendor])).input
      when ".ods" then Getter.new(Ods.new(filename, params[:vendor])).input
      else
        ReportMail.error("Unknown file type: filename", "[ERROR] report").deliver
      end
    rescue Exception => e
      ReportMail.error("Unable to save data from #{filename} because #{e.message}. Ip address: #{request.remote_ip}.", "[ERROR] report").deliver
    end
	end

  def vendors_with_report
    vendors_with_report = []
    directory = params.has_key?(:date) ? "report/#{params[:date][:year]}-#{params[:date][:month]}" : "report/#{DateTime.now.year}-#{DateTime.now.month}"
    Dir.foreach(directory) do |file|
      next if file == '.' or file == '..'
      vendors_with_report << Vendor.where(title: File.basename(file, ".*")).first
    end
    vendors_with_report.uniq
  end
end
