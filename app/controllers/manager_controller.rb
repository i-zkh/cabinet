# coding: utf-8
class ManagerController < ApplicationController
  def index
    @vendor_title = []
    @vendors_with_report = vendors_with_report
    (Vendor.all - @vendors_with_report).each { |v| @vendor_title << v.title }
    @month = params.has_key?(:date) ? params[:date][:month].to_i : Date.today
    @year  = params.has_key?(:date) ? params[:date][:year].to_i  : Date.today
  end

  # def import
  #   @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
  #   if params.has_key?(:file)
  #     begin
  #       open_spreadsheet(params[:file], params[:vendor])
  #     rescue ArgumentError
  #       redirect_to manager_report_url, notice: "Формат данной выгрузки не соответствует образцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Образец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
  #     rescue Exception => e
  #       redirect_to manager_report_url, notice: "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru "
  #     else 
  #       redirect_to manager_report_url, notice: "Файл успешно добавлен."
  #     end
  #   else
  #     redirect_to manager_report_url, notice: "Необходимо выбрать файл."
  #   end
  # end


  # def open_spreadsheet(file, vendor)
  #   FileUtils.mkpath "report/#{DateTime.now.year}-#{DateTime.now.month}"
  #   filename = "report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{vendor}" + "#{File.extname("#{file.original_filename}")}"
  #   File.open(File.join(filename), "wb") { |f| f.write(file.read) }
  #     case File.extname(file.original_filename).downcase
  #     when ".txt" then Getter.new(Txt.new(filename, current_user.id)).input
  #     when ".xls", ".xlsx" then Getter.new(Xls.new(filename, current_user.id)).input
  #     when ".dbf" then Getter.new(Dbf.new(filename, current_user.id)).input
  #     when ".ods" then Getter.new(Ods.new(filename, current_user.id)).input
  #     else
  #       raise FileSaveError, 'file have not a sample'
  #     end
  # end

  def import
    @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
    if params.has_key?(:file)
      filename = "report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{params[:vendor]}" + "#{File.extname("#{params[:file].original_filename}")}"
      File.open(File.join(filename), "wb") { |f| f.write(params[:file].read) }
      vendor = Vendor.where(title: params[:vendor])
      open_spreadsheet(filename, vendor)
    else
      redirect_to manager_report_url, notice: "Необходимо выбрать файл."
    end
  end

  def open_spreadsheet(filename, vendor)
    begin
      case File.extname(filename).downcase
      when ".txt" then Getter.new(Txt.new(filename, vendor.id)).input
      when ".xls", ".xlsx" then Getter.new(Xls.new(filename, vendor.id)).input
      when ".dbf" then Getter.new(Dbf.new(filename, vendor.id)).input
      when ".ods" then Getter.new(Ods.new(filename, vendor.id)).input
      else
        raise ArgumentError, 'file have not a sample'
      end
    rescue ArgumentError
      if Dir["report/sample/#{Vendor.where(id: vendor.id).first.title}.*"] == []
        redirect_to manager_report_url, notice: "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru "
      else
        redirect_to manager_report_url, notice: "Формат данной выгрузки не соответствует образцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Образец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
      end
    rescue Exception => e
      redirect_to manager_report_url, notice: "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru "
    else 
      redirect_to manager_report_url, notice: "Файл успешно добавлен."
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
