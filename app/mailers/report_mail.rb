class ReportMail < ActionMailer::Base
  default from: "out@izkh.ru"

  def report(message)
    @message = message
    mail to: "iva.anastya@gmail.com"
  end
end
