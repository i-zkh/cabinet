# coding: utf-8
#encoding: UTF-8
require 'iconv' unless String.method_defined?(:encode)

class VendorsController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :report, :report_test]

  def show
    @vendor   = Vendor.find(params[:vendor_id])
    @accounts = Account.where("vendor_id = ?", params[:vendor_id])
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
    if params.has_key?(:file)
      begin
        spreadsheet = open_spreadsheet(params[:file])
      rescue ArgumentError
        redirect_to report_url, notice: "Формат данной выгрузки не соответствует абразцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Абразец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
      rescue Exception => e
        ReportMail.error("Unable to save data from #{filename} because #{e.message}. Ip address: #{request.remote_ip}.", "[ERROR] report").deliver
        redirect_to report_url, notice: "Формат данной выгрузки не соответствует абразцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Абразец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
      else 
        redirect_to report_url, notice: "Файл успешно добавлен."
      end
    else
      redirect_to report_url, notice: "Необходимо выбрать файл. Абразец выгрузки можно скачать ниже."
    end
  end

  def import_test
    file = request.body.read
    File.open(File.join("wwwwwwow-xls.xls"), "wb") do |f| 
      if String.method_defined?(:encode)
        f.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
        f.encode!('UTF-8', 'UTF-16')
      else
        ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
        file_contents = ic.iconv(f)
      end
      p f.write(file_contents) 
    end
  end

  def sample
    send_file "report/sample/#{Vendor.where(id: current_user.id).first.title}.xls"
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
        raise ArgumentError, 'report don\'t have sample'
      end
  end
end