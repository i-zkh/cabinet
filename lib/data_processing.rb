class DataProcessing 

	def self.amount_to_service(vendor_id)
		user_amounts = []
		GetRequest.user_accounts(vendor_id).each do |u_a|
			account = Account.where('vendor_id = ? AND user_account = ?', vendor_id, u_a).first
			user_amounts << { vendor_id: vendor_id, user_account: account.user_account, amount: account.invoice_amount.to_f >= 0 ? 0 : account.invoice_amount.to_f*(-1) } if account
		end
		# PostRequest.payload(user_amounts)
	end

	def self.user_notifications(vendor_id)
		paid_accounts, users_data = [], []
		GetRequest.report_daily.each {|r| paid_accounts << r['user_account'] if r['vendor_id'] == vendor_id }
        GetRequest.users_data(vendor_id).each do |u_d| 
            amount = Account.where('vendor_id = ? AND user_account = ?', vendor_id, u_d['user_account']).first
            if !paid_accounts.include?(u_d["user_account"]) && amount
                users_data << { user_name: u_d['user_name'], user_email: u_d['user_email'], amount: amount }
            end
        end
        p users_data
        users_data.each {|u_d| send_user(u_d['user_name'], "iva.anastya@gmail.com", u_d['amount'])}
	end

	def self.send_user(name, email, amount)
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