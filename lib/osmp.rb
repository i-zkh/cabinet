class Osmp
    def self.check(account, date)
        uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%#{account}&txn_date=#{date.strftime("%Y%m%d%H%M%S")}&sum=10.45")

        require "net/https"
        require 'nokogiri'
        require "uri"

        pem = File.read("www_izkh_ru.pem")
        key = File.read("www_izkh_ru.key")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.cert = OpenSSL::X509::Certificate.new(pem)
        http.key = OpenSSL::PKey::RSA.new(key)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        
        response = http.request(Net::HTTP::Get.new(uri.request_uri))
        response

        response.css('response account_balance').each { |b| @balance = b.content }
        @balance
    end

    def self.pay(account, date, sum)
        uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=pay&txn_id=211119&account=2%#{account}&txn_date=#{date.strftime("%Y%m%d%H%M%S")}&sum=#{sum}")

        require "net/https"
        require "uri"
        
        pem = File.read("www_izkh_ru.pem")
        key = File.read("www_izkh_ru.key")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.cert = OpenSSL::X509::Certificate.new(pem)
        http.key = OpenSSL::PKey::RSA.new(key)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        
        response = http.request(Net::HTTP::Get.new(uri.request_uri))
        response
    end
end