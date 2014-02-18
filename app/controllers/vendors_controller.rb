# coding: utf-8
#encoding: UTF-8


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

  def destroy
    @vendor = Post.find(params[:id])
    @vendor.destroy
    redirect_to show_report_url
  end

  def report
    @vendor = current_user
    @month  = params.has_key?(:date) ? params[:date][:month].to_i : Date.today
    @year   = params.has_key?(:date) ? params[:date][:year].to_i  : Date.today
    FileUtils.mkpath "public/report/#{DateTime.now.year}-#{DateTime.now.month}"
  end

  def sample
    send_file "#{Dir["public/report/sample/#{Vendor.where(id: current_user.id).first.title}.*"][0]}"
  end

  def import
    if params.has_key?(:file)
      filename = "public/report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{Vendor.where(id: current_user.id).first.title}" + "#{File.extname("#{params[:file].original_filename}")}"
      File.open(File.join(filename), "wb") { |f| f.write(params[:file].read) }
      open_spreadsheet(filename)
    else
      redirect_to report_url, notice: "Необходимо выбрать файл."
    end
  end

  def import_drag
    filename = "public/report/#{DateTime.now.year}-#{DateTime.now.month}/" + "#{Vendor.where(id: current_user.id).first.title}" + "#{File.extname("#{request.headers['HTTP_X_FILENAME']}")}"
    File.open(File.join(filename), "wb") { |f| f.write(request.body.read) }
    open_spreadsheet(filename)
    end

  def open_spreadsheet(filename)
    begin
      case File.extname(filename).downcase
      when ".txt" then Getter.new(Txt.new(filename, current_user.id)).update
      when ".xls", ".xlsx" then Getter.new(Xls.new(filename, current_user.id)).update
      when ".dbf" then Getter.new(Dbf.new(filename, current_user.id)).update
      when ".ods" then Getter.new(Ods.new(filename, current_user.id)).update
      else
        raise ArgumentError, 'file have not a sample'
      end
    rescue ArgumentError
      if Dir["public/report/sample/#{Vendor.where(id: current_user.id).first.title}.*"] == []
        redirect_to report_url, notice: "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru "
      else
        redirect_to report_url, notice: "Формат данной выгрузки не соответствует образцу, предоставленному вами ранее. Просим переделать выгрузки и повторить добавление. Образец можно скачать ниже. По возникшим вопросом Вы можете проконсультироваться по телефонам 373-64-10, 373-64-11."
      end
    rescue Exception => e
      redirect_to report_url, notice: "Образец данной выгрузки отсутсвует в базе. Для внесения её в систему отправьте выгрузку на почтовый адрес system@izkh.ru "
    else 
      redirect_to report_url, notice: "Файл успешно добавлен."
    end
  end
end