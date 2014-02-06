# coding: utf-8
#encoding: UTF-8
class VendorsController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :report]

  def show
    @vendor   = Vendor.find(params[:vendor_id])
    p @accounts = Account.where("vendor_id = ?", params[:vendor_id])
  end

  def edit
    @vendor = current_user
  end

  def update
    @vendor = current_user
    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.html { redirect_to @vendor, notice: 'Данные успешно обновлены.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def report
    @vendor = current_user
    @month  = params.has_key?(:date) ? params[:date][:month].to_i : Date.today
    @year   = params.has_key?(:date) ? params[:date][:year].to_i  : Date.today
  end

  def import
    @vendors = Vendor.all.select{ |v| !File.exists?(v.title) }
    @button = false
    if params.has_key?(:file)
      begin
        spreadsheet = open_spreadsheet(params[:file])
      rescue ArgumentError
        redirect_to report_url, notice: "Формат данной выгрузки не соответствует абразцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Абразец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
        @button = true
      rescue Exception => e
        ReportMail.error("Unable to save data from #{filename} because #{e.message}. Ip address: #{request.remote_ip}.", "[ERROR] report").deliver
      else 
        redirect_to report_url, notice: "Файл успешно добавлен."
      end
    else
      redirect_to report_url, notice: "Необходимо выбрать файл."
    end
  end

  def sample
    send_file 'report/sample/ТСЖ "Спорт-3".xls'
  end

  def open_spreadsheet(file)
    FileUtils.mkpath "report/#{DateTime.now.year}-#{DateTime.now.month}"
    filename = "report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{Vendor.where(id: current_user.id).first.title}" + "#{File.extname("#{file.original_filename}")}"
    File.open(File.join(filename), "wb") { |f| f.write(file.read) }
      case File.extname(file.original_filename).downcase
      when ".txt" then Getter.new(Txt.new(filename, current_user.id)).input
      when ".xls", ".xlsx" then Getter.new(Xls.new(filename, current_user.id)).input
      when ".dbf" then Getter.new(Dbf.new(filename, current_user.id)).input
      when ".ods" then Getter.new(Ods.new(filename, current_user.id)).input
      else
        ReportMail.error("Unknown file type: filename", "[ERROR] report").deliver
      end
  end
end