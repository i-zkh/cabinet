#encoding: utf-8
class ReportMail < ActionMailer::Base
  default from: "out@izkh.ru"
  default to: "out@izkh.ru"

  def report(message, vendor)
    @message = message
    attachments["#{vendor.title}.txt"] = File.read("#{vendor.title}.txt")
    mail(to: vendor.email, subject: "АйЖКХ")
  end

  def accounts
    attachments["report.txt"] = File.read("report.txt")
    mail(to: "out@izkh.ru", subject: "ERROR")
  end

  def no_transactions
    mail(to: "out@izkh.ru", subject: "No transactions")
  end
end