#encoding: utf-8
class ReportForManager < Payment
  attr_accessor :data

  def initialize(data)
   @data = data
  end

  def output
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "data") do |sheet|
        sheet.add_row ["Название организации", "Лицевой счет", "Адрес", "Сумма платежа", "Дата транзакции", "Тип транзакции"]
        @data.each do |data|
          data = data.split(';')
          sheet.add_row [data[5], data[1], data[2], data[3].to_f + data[4].to_f , data[7], data[0]] 
       end
      end
      p.serialize("transactions.xls")
    end
  end
end