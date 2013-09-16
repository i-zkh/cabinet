#encoding: utf-8
class ReportMail < ActionMailer::Base
  default from: "out@izkh.ru"
  default to: "out@izkh.ru"

  def report(message, vendor)
    @message = message
    attachments["#{vendor.title}.txt"] = File.read("#{vendor.title}.txt")
    mail(to: vendor.email, subject: "АйЖКХ")
  end

  def report_to_out
    attachments["report.txt"] = File.read("report.txt")
    mail(to: "out@izkh.ru", subject: "Report")
  end

  def no_transactions
    mail(to: "out@izkh.ru", subject: "No transactions")
  # mail(to: "ivanova@izkh.ru", subject: "No transactions")
  end

  def error(message)
    @message = message
    mail(to: "out@izkh.ru", subject: "[ERROR] user accounts")
  end

  def booker(recipient)
      attachments["transactions.txt"] = File.read("transactions.txt")
      mail(to: recipient, subject: "АЙЖКХ")
     # mail(to: "Gluhovskaya.o@delta.ru", subject: "АЙЖКХ")
   end
end