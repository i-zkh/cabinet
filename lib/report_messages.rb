#encoding: utf-8
class ReportMessages
	def self.monthly_report(email, filename)
		require 'mandrill'
    	mandrill = Mandrill::API.new 'Sa9QSFZ8ZFAIJVosKwnqBQ'
    	message = {  
    	  :subject=> "Сервис АйЖКХ",  
    	  :from_name=> "Сервис АйЖКХ ",
    	  :to=>[{  
    	      :email=> email,  
    	      :name=> name
    	  }], 
    	  :attachments=>[{
    	  	:type=>"text/plain",
            :name=>filename,
            :content=>ActiveSupport::Base64.encode64(open(filename) { |io| io.read })
            }], 
    	  :html=>
    	    "<html>
    	      <p>
 				Выгрузка транзакций АйЖКХ за #{Date.today.month}
    	      </p>
    	    </html>",
    	  :from_email=>"out@izkh.ru"
    	} 
    	mandrill.messages.send message
	end

	def self.send_user_amount(name, email, amount)
		require 'mandrill'
		vendors_title = ""
    	Vendor.where("created_at > ?", 31.days.ago).each {|v| vendors_title += "<li>#{v.title}</li>" }
    	mandrill = Mandrill::API.new 'Sa9QSFZ8ZFAIJVosKwnqBQ'
    	message = {  
    	  :subject=> "Сервис АйЖКХ",  
    	  :from_name=> "Сервис АйЖКХ ",  
    	  :to=>[{  
    	      :email=> email,  
    	      :name=> name
    	  }],  
    	  :html=>
    	    "<html><h1>Уважаемый пользователь #{name}!</h1>
    	      <p>
 				Мы заметили, что Вы не оплатили ежемесячный платеж из списка Ваших услуг. Напоминаем Вам, что eжемесячный платеж составляет #{amount} рублей.<br>
    	        Оплатить услуги можно с помощью <a href='http://izkh.ru'>сайта айжкх.рф</a><br>
    	        <img src='https://izkh.ru/images/web.png' width='370' height='100'/><br>
    	        или мобильного приложения на iOS<br><br>
    	        Для загрузки iOS-приложения перейдите по ссылке или воспользуйтесь QR-кодом:<br>
    	        <a href='http://itunes.apple.com/ru/app/servis-ajzkh/id649860222?mt=8'>
    	          <img src='https://izkh.ru/images/apple.png' width='90' height='90' />
    	        </a>
    	        <img src='https://izkh.ru/images/qr.png' width='90' height='90'/>
    	      <ul>
    	        <li>узнавайте и оплачивайте задолженность за услуги ЖКХ</li>
    	        <li>передавайте данные Ваших счетчиков в адрес своего ТСЖ или УК</li>
    	        <li>оплачивайте другие услуги: Интернет, ТВ, домофон, охранные услуги</li>
    	      </ul>
    	      Рады сообщить, что добавились новые поставщики услуг:
    	        <ul>
    	          #{vendors_title}
    	        </ul>
    	      Посмотреть полный список поставщиков можно на нашем <a href='http://izkh.ru/catalog'>сайте айжкх.рф</a><br><br>
    	      Не нашли своего поставщика? <a href='http://izkh.ru/request_for_vendor'>Напишите нам</a><br><br>
    	      Присоединяйтесь к нам в соц.сетях<br><br>
    	      <a href='https://vk.com/izkh_official'>
    	        <img src='https://izkh.ru/images/vk.png' />
    	      </a>
    	      <a href='https://www.facebook.com/pages/%D0%9E%D0%9E%D0%9E-%D0%90%D0%B9%D0%96%D0%9A%D0%A5/730802226933352'>
    	        <img src='https://izkh.ru/images/f.png' />
    	      </a>
    	      <a href='https://twitter.com/izkh_official'>
    	        <img src='https://izkh.ru/images/t.png' />
    	      </a><br><br>
    	      <i>
    	        Вы получили это сообщение, потому что являетесь клиентом АйЖКХ.<br><br>
    	        Безопасность операций соответствует требованиям международного стандарта PCI DSS.<br>
    	        Услугу по переводу денежных средств оказывает ОАО АКБ \"Банк Москвы\" лицензия Банка России №2748.<br>
    	        Полный список тарифов и поставщиков  на сайте <a href='http://izkh.ru'>айжкх.рф</a>
    	      </i>
    	    </html>",
    	  :from_email=>"out@izkh.ru"
    	} 
    	mandrill.messages.send message
	end	
end