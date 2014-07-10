#encoding: utf-8
class ReportForManager < Payment
  attr_accessor :data

  def initialize(data, transactions_type)
   @data = data
   @transactions_type = transactions_type
  end

  def output
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "data") do |sheet|
        sheet.add_row ["Название организации", "Лицевой счет", "Адрес", "Сумма платежа", "Дата транзакции", "Тип транзакции"]
        @data.each do |data|
          data = data.split(';')
          sheet.add_row [data[5], data[1], data[2], data[3].to_f + data[4].to_f , data[7], @transactions_type[data[0].to_i] ]
       end
      end
      p.serialize("transactions.xls")
    end
  end
end