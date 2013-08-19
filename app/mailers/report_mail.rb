#encoding: utf-8
class ReportMail < ActionMailer::Base
  default from: "out@izkh.ru"
  default to: "ivanova@izkh.ru"

  def report(message, vendor)
    @message = message
    attachments["#{vendor.title}.txt"] = File.read("#{vendor.title}.txt")
    mail(to: vendor.email, subject: "АйЖКХ")
  end

  def accounts
    attachments["absence_user_account.txt"] = File.read("absence_user_account.txt")
    mail(to: "ivanova@izkh.ru", subject: "report")
  end
end