#encoding: UTF-8
class AccountsController < ApplicationController

  def edit
  	
  end 

  def create
	
	# Date for November
	# Getter.new(Xls.new("report/11-2013/ТСЖ 247 б.xls", 62)).input
	# Getter.new(Ods.new("report/11-2013/privol.ods", 49)).input
	# Getter.new(Xls.new("report/11-2013/Лицевые Счета ЖСК №29.xls", 109)).input
	# Getter.new(Xls.new("report/11-2013/bus_center.xls", 110)).input
	# Getter.new(Dbf.new("report/11-2013/N0011310.DBF", 113)).input
	# Getter.new(Xls.new("report/11-2013/ТСЖ Перспектива.xls", 114)).create
	# Getter.new(Dbf.new("report/11-2013/сов 147.DBF", 112)).create
	# Getter.new(Xls.new("report/11-2013/Спорт3 реестр 10 13.xls", 111)).create
	# Getter.new(Xls.new("report/11-2013/промышленный № 261.xls", 15)).create
	# Getter.new(Xls.new("report/11-2013/254.xls", 58)).create
	# Getter.new(Xls.new("report/11-2013/ивушка.xls", 56)).create
	# Getter.new(Xls.new("report/11-2013/КЖСК № 298.xls", 50)).create
	# Getter.new(Xls.new("report/11-2013/ЖСК 138 выгрузка.xls", 120)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 136 выгрузка.xls", 122)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 100 выгрузка.xls", 126)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 96 выгрузка.xls", 124)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 9 выгрузка.xls", 125)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 11 выгрузка.xls", 119)).create
	# Getter.new(Xls.new("report/11-2013/ТСЖ Советский 137 выгрузка.xls", 123)).create
	# Getter.new(Xls.new("report/11-2013/Выгрузка ЖСК-265, ЛС.xls", 127)).create
	# Getter.new(Ods.new("report/11-2013/приволжское.ods", 49)).create
	# Getter.new(Xls.new("report/11-2013/serebren.xls", 42)).create

    render json: true
  end

  def update
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
	# Getter.new(Xls.new("report/1-2014/Спорт3 реестр 12 13.xls", 112)).input

	# Getter.new(Xls.new("report/12-2013/ТСЖ Железнодорожный № 141.xls", 142)).update

	# CheckEmail.get_organizations
	# p Roo::Excel.new("organizations/#{DateTime.now.month}-#{DateTime.now.day}-Organizations.xls")

	# Getter.new(Xls.new("report/sample/#{Vendor.find(58).title}.xls", 58)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(38).title}.xls", 38)).input
	# Getter.new(Ods.new("report/sample/#{Vendor.find(65).title}.ods", 65)).input
	# Getter.new(Dbf.new("report/sample/#{Vendor.find(61).title}.DBF", 61)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(47).title}.xls", 47)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(46).title}.xls", 46)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(59).title}.xls", 59)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(63).title}.xls", 63)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(92).title}.xls", 92)).input


	# Getter.new(Xls.new("report/sample/#{Vendor.find(56).title}.xls", 56)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(50).title}.xls", 50)).input
	# Getter.new(Ods.new("report/sample/#{Vendor.find(49).title}.ods", 49)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(15).title}.xls", 15)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(112).title}.xls", 112)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(42).title}.xls", 42)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(66).title}.xls", 66)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(129).title}.xls", 129)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(137).title}.xls", 137)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(93).title}.xls", 93)).input
	# Getter.new(Xls.new("report/sample/#{Vendor.find(62).title}.xlsx", 62)).input

    fuke = File.new("vendors.txt", "w")
        Vendor.all.each do |v|
         	fuke.puts("#{v.title}") if Account.where("user_account IS NOT NULL AND vendor_id = #{v.id}").first
     	end
        
     fuke.close

    render json: true
  end
end