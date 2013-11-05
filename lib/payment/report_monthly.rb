#encoding: utf-8
class ReportMonthly < Payment
  attr_accessor :data

  def initialize(data, vendor_id)
    @data = data
    @vendor_id = vendor_id
  end

  def monthly
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Report") do |sheet|
        sheet.add_row ["Лицевой счет", "Сумма", "Дата"]
        @data.each do |d|
          sheet.add_row [d["user_account"], d["amount"], DateTime.parse(d['date']).strftime("%Y-%m-%d")]
        end
      end
      p.serialize("report_monthly/#{DateTime.now.month}-#{DateTime.now.year}/" + "#{Vendor.find(@vendor_id).title.gsub!(/"/, "")}.xls")
    end
  end
end