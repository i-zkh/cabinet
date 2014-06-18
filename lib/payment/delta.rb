#encoding: utf-8
class Delta < Payment
  attr_accessor :data

  def initialize(data, id)
    @data = data
    @id = id
  end

  def output
    hash, i_p, s_p = {}, [], []
    @data.each do |d| 
      bid = Bid.find_by_key(d.split(';')[9]) 
      i_p = hash["#{bid.installation_payment_for_vendor}"] if hash.has_key?("#{bid.installation_payment_for_vendor}")
      i_p << "Монтаж;#{bid.contract_number};#{bid.name};#{bid.phone};#{bid.installation_payment};#{bid.created_at.strftime("%Y-%m-%d")};#{bid.id}"
      hash["#{bid.installation_payment_for_vendor}"] = i_p
      s_p = hash["#{bid.service_payment_for_vendor}"] if hash.has_key?("#{bid.service_payment_for_vendor}")
      s_p << "Охрана;#{bid.contract_number};#{bid.name};#{bid.phone};#{bid.service_payment_for_vendor};#{bid.created_at.strftime("%Y-%m-%d")};#{bid.id}"
      hash["#{bid.service_payment_for_vendor}"] = s_p
    end
    hash.each do |key, value|
      filename = "#{key}.xlsx"
      Axlsx::Package.new do |p|
        p.workbook.add_worksheet(:name => "Report") do |sheet|
          sheet.add_row ["Платежи населения, принятые через сервис АйЖКХ в пользу ООО ЧОП \"Команда\" "]
          sheet.add_row ["Услуга", "№ договора", "ФИО клиента", "Номер телефона", "Сумма платежа", "Дата платежа", "Номер операции"]
          value.each do |d|
            d = d.split(';')
            sheet.add_row [d[0], d[1], d[2], d[3], d[4], d[5], d[6]]
          end
        end
        p.serialize(filename)
      end
      filename
    end
  end
end