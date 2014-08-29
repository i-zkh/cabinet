#encoding: utf-8
require 'russian'
class DeltaWorker
  include Sidekiq::Worker
  
    def perform(key, email, installation_payment, installation_payment_for_vendor, service_payment, service_payment_for_vendor)
    require 'mandrill'
    mandrill = Mandrill::API.new 'NToYNXQZRClqYQkDai6ujg'
    service_payment = service_payment.nil? ? 0 : service_payment
    message = {  
      :subject=> "Заявка на оплату услуг компании DELTA",  
      :from_name=> "DELTA",  
      :text=>"Заявка на оплату услуг компании DELTA",  
      :to=>[{
          :email=> email,
      }],  
      :html=>
        "<html><h3>Заявка на оплату услуг компании DELTA</h3>
          <p>Стоимость установки системы DELTA, руб: #{installation_payment}</p>
          <p>Компания, устанавливающая систему: #{installation_payment_for_vendor}</p>
          <p>Стоимость ежемесячного обслуживания, руб: #{service_payment}</p>
          <p>Компания, обеспечивающая охрану: #{service_payment_for_vendor}</p>
          <b>Итого к оплате: #{installation_payment + service_payment}</b>
          <p>Для проведения оплаты пройдите по ссылке ниже:</p>
          <a href='http://izkh.ru/delta_payment?key=#{key}'>Перейти к оплате</a>
        </html>",
      :from_email=>"out@izkh.ru"
    } 
    mandrill.messages.send message
    end
end
