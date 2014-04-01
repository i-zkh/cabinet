#encoding: utf-8
class ReportMonthly < Payment
  attr_accessor :data

  def initialize(data, vendor_id)
    @data = data
    @vendor_id = vendor_id
  end

  def monthly
    filename = "/home/ubuntu/apps/project/shared/transactions/" + "#{@vendor_id}.xls"
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Report") do |sheet|
        sheet.add_row ["Лицевой счет", "Сумма", "Дата"]
        @data.each { |d| sheet.add_row [d["user_account"], d["amount"], DateTime.parse(d['date']).strftime("%Y-%m-%d")] }
      end
      p.serialize(filename)
    end
    filename
  end
end