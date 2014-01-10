#encoding: utf-8
class ReportMail < ActionMailer::Base
  default from: "out@izkh.ru"
  default to: "out@izkh.ru"

  def report(message, vendor)
    @message = message
    attachments["#{vendor.title}.txt"] = File.read("#{vendor.title}.txt")
    mail(to: vendor.email, subject: "АйЖКХ")
  end

  def report_monthly(message, vendor)
    @message = message
    attachments["#{vendor.title}.xls"] = File.read("report_monthly/12-2013/#{vendor.title.gsub(/"/, "")}.xls")
    mail(to: vendor.email, subject: "АйЖКХ")
  end

  def report_to_out
    attachments["report.txt"] = File.read("report.txt")
    mail(to: "out@izkh.ru", subject: "Report")
  end

  def report_to_manager
    attachments["report.txt"] = File.read("report.txt")
    mail(to: "yusova@izkh.ru", subject: "Report")
  end


  def no_transactions
    mail(to: "out@izkh.ru", subject: "No transactions")
  end

  def error(message, message_subject)
    @message = message
    mail(to: "out@izkh.ru", subject: message_subject)
  end

  def booker(recipient)
      attachments["transactions.txt"] = File.read("transactions.txt")
      mail(to: recipient, subject: "АЙЖКХ")
   end

   def auth_keys(vendor)
      @title = vendor.title
      @email = vendor.email
      @auth = vendor.auth_key
      mail(to: vendor.email, subject: "АйЖКХ")
   end
end