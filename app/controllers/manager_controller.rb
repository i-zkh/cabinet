# coding: utf-8
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
      #/home/ubuntu/apps/project/shared/
      filename = "/home/ubuntu/apps/project/shared/report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{vendor.id}" + "#{File.extname("#{params[:file].original_filename}")}"
      File.open(File.join(filename), "wb") {|f| f.write(params[:file].read)}
      open_spreadsheet(filename, vendor.id)
    else
      redirect_to manager_report_url, notice: "Необходимо выбрать файл и поставщика."
    end
  end

  def open_spreadsheet(filename, vendor_id)
    begin
      case File.extname(filename).downcase
      when ".txt"          then @data = Getter.new(Txt.new(filename, vendor_id)).input
      when ".xls", ".xlsx" then @data = Getter.new(Xls.new(filename, vendor_id)).input
      when ".dbf"          then @data = Getter.new(Dbf.new(filename, vendor_id)).input
      when ".ods"          then @data = Getter.new(Ods.new(filename, vendor_id)).input
      else
        raise ArgumentError, 'file have not a sample'
      end
      WebReportWorker.perform_async(@data, vendor_id)
    rescue FiberError
      flash[:notice] = "Файл успешно добавлен."
      WebReportWorker.perform_async(Xls.new(filename, vendor_id).manager, vendor_id)
    rescue Exception => e
      File.delete(filename)
      flash[:notice] = Dir["public/sample/#{Vendor.where(id: vendor_id).first.title}.*"] == [] ? "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru" : "Формат данной выгрузки не соответствует образцу, предоставленному вами ранее. Просим переделать выгрузку и повторить добавление."
    else 
      flash[:notice] = "Файл успешно добавлен."
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
