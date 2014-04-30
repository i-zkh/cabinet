#encoding: utf-8
class Factorial < Payment
  attr_accessor :data

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    sum, filename = 0, "#{Date.today.strftime("%d%m%y")}.txt"
    reportFile = File.new(filename, "w:CP866")
    @data.each {|d| sum = sum + d['amount']}
    reportFile.puts("# #{Date.today.strftime("%d%m%y")} ;Номер реестра\n" +
                    "# #{sum} ;Сумма реестра\n" +
                    "# ;В том числе пеня\n" +
                    "# 0.0 ;Удержанная сумма\n" +
                    "# #{sum} ;Сумма к перечислению\n" +
                    "# #{@data.count} ;Число записей\n" +
                    "# ;Код агента\n" +
                    "# ;Номер \"услуги\"\n" +
                    "# #{DateTime.now.strftime("%d/%m/%Y %H:%M:%S")} ;Дата формирования реестра\n" +
                    "# #{DateTime.now.strftime("%d/%m/%Y %H:%M:%S")} ;Начало диапазона дат документов, входящих в реестр\n" +
                    "# #{DateTime.now.strftime("%d/%m/%Y %H:%M:%S")} ;Конец диапазона дат документов, входящих в реестр\n"
    )
    @data.each do |d|
        ";#{d['address']};#{d['user_account']};#{d['amount']};1;01/#{DateTime.now.strftime("%m/%Y")};#{Date.today.end_of_month.strftime("%d/%m/%Y")};;#{Date.today.end_of_month.strftime("%d/%m/%Y")};;#{d['date'].nil? ? DateTime.parse(d['created_at']).strftime("%d.%m.%Y") : DateTime.parse(d['date']).strftime("%d.%m.%Y")};;"
    end
    @data.each {|d| reportFile.puts(";#{d['address']};#{d['user_account']};#{d['amount']};1;01/#{DateTime.now.strftime("%m/%Y")};#{Date.today.end_of_month.strftime("%d/%m/%Y")};;#{d['date'].nil? ? DateTime.parse(d['created_at']).strftime("%d.%m.%Y") : DateTime.parse(d['date']).strftime("%d.%m.%Y")};;")}
    reportFile.close
    filename
  end
end