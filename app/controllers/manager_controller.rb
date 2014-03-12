# encoding: utf-8
class ManagerController < ApplicationController
  def index
    @vendor_title = []
    @month = params.has_key?(:date) ? params[:date][:month].to_i : Date.today.month
    @year  = params.has_key?(:date) ? params[:date][:year].to_i  : Date.today.year
    FileUtils.mkpath "/home/ubuntu/apps/project/shared/report/#{@year}-#{@month}"
    @vendors_with_report = vendors_with_report
    Vendor.all.each { |v| @vendor_title << v.title }
  end

  def import
    @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
    vendor = Vendor.where(title: params[:vendor]).first
    if params.has_key?(:file) && vendor
      filename = "/home/ubuntu/apps/project/shared/report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{vendor.id}" + "#{File.extname("#{params[:file].original_filename}")}"
      File.open(File.join(filename), "wb") {|f| f.write(params[:file].read)}
      WebReportWorker.perform_async(filename, vendor.id)
    else
      flash[:notice] = "Необходимо выбрать файл и поставщика."
    end
    redirect_to manager_report_url
  end

  def vendors_with_report
    vendors_with_report = []
    directory = params.has_key?(:date) ? "/home/ubuntu/apps/project/shared/report/#{params[:date][:year]}-#{params[:date][:month]}" : "/home/ubuntu/apps/project/shared/report/#{DateTime.now.year}-#{DateTime.now.month}"
    Dir.foreach(directory) do |file|
      next if file == '.' or file == '..'
      vendors_with_report << Vendor.where(id: File.basename(file, ".*")).first
    end
    vendors_with_report.uniq
  end
end