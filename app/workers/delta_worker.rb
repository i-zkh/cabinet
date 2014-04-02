#encoding: utf-8
require 'russian'
class DeltaWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(bid)
    mandrill = Mandrill::API.new 'WT_DRSPlVKfp2sBM-TsZ_w'

    message = {  
      :subject=> "Заявка на услуги компании delta",  
      :from_name=> "Delta",  
      :text=>"Заявка на услуги компании delta",  
      :to=>[{
          :email=> "iva.anastya@gmail.com",
      }],  
      :html=>
        "<html><h1>Заявка</h1>
          #{bid}
          <p>Для проведения опталы пройдите по ссылке ниже</p>
          <a href='http://izkh.ru'>Подтвердить</a>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
    end
end
