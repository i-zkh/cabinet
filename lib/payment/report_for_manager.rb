#encoding: utf-8
class ReportForManager < Payment
  attr_accessor :data

  def initialize(data)
   @data = data
   @transactions_type = ["", "PayOnline", "Yandex", "WebMoney"]
  end

  def output
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "data") do |sheet|
        sheet.add_row ["Название организации", "Лицевой счет", "Город", "Адрес", "Сумма платежа", "Дата транзакции", "Тип транзакции"]
        @data.each do |data|
          address = data['address'].split(',')
          sheet.add_row [Vendor.find(data['vendor_id']).title, data["user_account"], address[0], address[1] + "," + address[2] + "," + address[3], data['amount'], DateTime.parse(data['date']).strftime("%Y-%m-%d"), @transactions_type[data['payment_type'].to_i]] 
       end
      end
      p.serialize("transactions.xls")
    end
  end
end