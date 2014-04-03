#encoding: utf-8
require 'russian'
class DeltaWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(key, email)
    require 'mandrill'
    mandrill = Mandrill::API.new 'Sa9QSFZ8ZFAIJVosKwnqBQ'

    message = {  
      :subject=> "Заявка на услуги компании delta",  
      :from_name=> "Delta",  
      :text=>"Заявка на услуги компании delta",  
      :to=>[{
          :email=> "iva.anastya@gmail.com",
      }],  
      :html=>
        "<html><h1>Заявка</h1>

          <p>#{key}Для проведения оплаты пройдите по ссылке ниже</p>
          <a href='http://izkh.ru'>Подтвердить</a>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
    end
end
