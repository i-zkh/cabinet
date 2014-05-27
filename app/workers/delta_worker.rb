#encoding: utf-8
require 'russian'
class DeltaWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(key, email)
    require 'mandrill'
    mandrill = Mandrill::API.new 'NToYNXQZRClqYQkDai6ujg'

    message = {  
      :subject=> "Заявка на оплату услуг компании DELTA",  
      :from_name=> "DELTA",  
      :text=>"Заявка на оплату услуг компании DELTA",  
      :to=>[{
          :email=> email,
      }],  
      :html=>
        "<html><h3>Заявка на оплату услуг компании DELTA</h3>

          <p>Для проведения оплаты пройдите по ссылке ниже:</p>
          <a href='http://izkh.ru/delta_payment?key=#{key}'>Перейти к оплате</a>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
    end
end
