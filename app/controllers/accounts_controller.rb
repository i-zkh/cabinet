#encoding: UTF-8
class AccountsController < ApplicationController

  def index
    @accounts = Account.where('vendor_id = ?', params[:vendor_id])
	@vendor = Vendor.find(params[:vendor_id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to :back
  end

  def update
  	# Report.new(Factorial.new(GetRequest.transactions(150, Date.today.month))).output_report

	# Energosbyt.new("report/1-2014/Сбыт_Энерго_дек.xls").update
	# Getter.new(Xls.new("report/11-2013/254.xls", 58)).input
	# Getter.new(Xls.new("report/12-2013/Спорт3 реестр 11 13.xls", 112)).create
	# Getter.new(Dbf.new("report/12-2013/147.DBF", 111)).create
	# Getter.new(Dbf.new("report/12-2013/лидер.DBF", 61)).update
	# Getter.new(Xls.new("report/12-2013/ЖСК - 199 11.xls", 63)).update
	# Getter.new(Xls.new("report/12-2013/ЖСК - 219 11.xls", 38)).update
	# Getter.new(Xls.new("report/12-2013/ЖСК - 247 11.xls", 129)).update
	# Getter.new(Xls.new("report/12-2013/КЖСК № 298.xls", 50)).update
	# Getter.new(Xls.new("report/12-2013/ТСЖ Сокол ноябрь.xls", 92)).update
	# Getter.new(Xls.new("report/12-2013/Ноябрь ТСЖ Ивушка.xls", 56)).input
	# Getter.new(Xls.new("report/12-2013/ТСЖ Единство ноябрь.xls", 66)).update
	# Getter.new(Xls.new("report/12-2013/ТСЖ _У Озера-4_.xls", 141)).input
	# Getter.new(Xls.new("report/12-2013/ТСЖ Набережное.xls", 93)).update
	# Getter.new(Xls.new("report/12-2013/ТСЖ 247 Б", 62)).input

	# Getter.new(Txt.new("report/12-2013/Цифрал-Автоград.TXT", 43)).update
	# Getter.new(Txt.new("report/1-2014/Цифрал-Сервис.TXT", 43)).update
	# Getter.new(Xls.new("report/1-2014/Спорт5 реестр 12 13.xls", 137)).input

	# Getter.new(Xls.new("report/12-2013/ТСЖ Железнодорожный № 141.xls", 142)).update

	# CheckEmail.get_organizations
	# p Roo::Excel.new("organizations/#{DateTime.now.month}-#{DateTime.now.day}-Organizations.xls")

	render json: true
  end
end