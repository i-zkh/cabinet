require 'openssl'
require "net/https"
require "net/http"
require "uri"
#encoding: utf-8
class RequestController < ApplicationController
  def add_vendor_to_service
  	#PostRequest.vendor("test", 4)
    render json: true
  end

  def request_tariff_template
    PostRequest.tariff_template("title", 105, 2, false)
    render json: true
  end

  def request_field_template
    PostRequest.field_template("title", 100.00, true, 200, "field_type", 'field_units')
    render json: true
  end

  def get_vendor 
    @data = GetRequest.vendors
    (0..@data.size-1).each do |i|
      vendor = Vendor.where(title: @data[i]["vendor"]["title"]).first
      if !vendor
      #k = (0...5).map{('a'..'z').to_a[rand(26)]}.join
      #vendor_key = Digest::MD5.hexdigest(k)
        #Vendor.create!(id: @data[i]["vendor"]["id"], title: @data[i]["vendor"]["title"], auth_key: vendor_key)
      end
    end  
    render json: true
  end

  def osmp
  #  p response = HTTParty.get( "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%230034586&txn_date=20120827123230&sum=10.45&sign-md5=#{"ijkh.pem"}" )
  #  p @res = response.parsed_response
  #  render json: @res

  #  cert = OpenSSL::X509::Certificate.new(File.open("read.pem"))
  #p response = HTTParty.get( "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%230034586&txn_date=20120827123230&sum=10.45", {:ssl_client_cert => cert})
  #p @res = response.parsed_response
  # render json: @res
  
#  uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%230034586&txn_date=20120827123230&sum=10.45")
#  pem = File.read("ijkh.pem")
#  pembg = File.read("bgbilling.pem")
#  http = Net::HTTP.new(uri.host, uri.port)
#  http.use_ssl = true
#  http.cert = OpenSSL::X509::Certificate.new(pem)
#  http.key = OpenSSL::PKey::RSA.new(pembg)
#  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# request = Net::HTTP::Get.new(uri.request_uri)
#   response = http.request(request)

# IT's WORK
    uri = URI("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130909160900&sum=10.45")
  # http = Net::HTTP.new(uri.host, uri.port)
  # http.use_ssl = true
  # http.cert = OpenSSL::X509::Certificate.new(File.read("ijkh.pem"))
  # #http.verify_mode = OpenSSL::SSL::VERIFY_PEER 
  # p request = Net::HTTP::Get.new(uri.path)

  # Net::HTTP.start(uri.host, uri.port,
  #   :use_ssl => uri.scheme == 'https') do |http|
  #   http.cert = OpenSSL::X509::Certificate.new(File.read("ijkh.pem"))
  #     http.ca_file = Rails.root.join('bgbilling.pem')
  #     http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  #     http.original_use_ssl = true
  #   request = Net::HTTP::Get.new uri

  #   response = http.request(request)
  # end
  #   p response

# uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130909160900&sum=10.45")
# pem = File.read("ijkh.pem")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE
# http.cert = OpenSSL::X509::Certificate.new(pem)
# #http.key = OpenSSL::PKey::RSA.new(pem)

# store = OpenSSL::X509::Store.new
# store.set_default_paths # Optional method that will auto-include the system CAs.
# store.add_cert(OpenSSL::X509::Certificate.new(File.read("ijkh.pem")))
# store.add_cert(OpenSSL::X509::Certificate.new(File.read("bgbilling.pem")))
# http.cert_store = store

# response = http.request(Net::HTTP::Get.new(uri.request_uri))
# p response.body

# # uri = URI("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130909160900&sum=10.45")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER
# http.cert = OpenSSL::X509::Certificate.new(File.new('ijkh.pem'))
# response = http.request(Net::HTTP::Get.new(uri.path))
# response.body

# uri = URI("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130909160900&sum=10.45")
# req = Net::HTTP::Get.new(url.path)
# sock = Net::HTTP.new('193.33.144.3', '65443')
# sock.use_ssl = true
# store = OpenSSL::X509::Store.new
# store.add_cert OpenSSL::X509::Certificate.new(File.new('ijkh.pem'))
# sock.cert_store = store
# sock.start do |http|
#   response = http.request(req)
# end


# pem = File.read("ijkh.pem")
# uri = URI("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130909160900&sum=10.45")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.cert = OpenSSL::X509::Certificate.new(pem)
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER
# response = http.request(Net::HTTP::Get.new(uri.path))
# response.body

#url = URI.parse 'https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%230034586&txn_date=20130905112330&sum=10.45'
#http = Net::HTTP.new(url.host, url.port)
#http.use_ssl = (url.scheme == 'https')
#http.cert = OpenSSL::X509::Certificate.new(pem)
#  http.verify_mode = OpenSSL::SSL::VERIFY_NONE 
#request = Net::HTTP::Get.new(url.path)
#p response = http.request(request)
#p response.body
#  uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%230034586&txn_date=20120827123230&sum=10.45")
#  request = Net::HTTP::Get.new(uri.request_uri)
#  response.cert = OpenSSL::X509::Certificate.new(File.read("ijkh.pem"))
#  
#  response = Net::HTTP.new(uri.host, uri.port)
#  p request.body
#  p request.message

# uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%230034586&txn_date=20120827123230&sum=10.45")
# pem = File.read("bgbilling.pem")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.cert = OpenSSL::X509::Certificate.new(pem)
# http.key = OpenSSL::PKey::RSA.new(pem)
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER
# 
# request = Net::HTTP::Get.new(uri.request_uri)

# pem = File.read("ijkh.pem")
# http.use_ssl = true
# http.cert = OpenSSL::X509::Certificate.new(pem)
# http.key = OpenSSL::PKey::RSA.new(pem)
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER

#############################
# uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20131309120000&sum=10.45")
# pem = File.read("ijkh.pem")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE
# http.cert = OpenSSL::X509::Certificate.new(pem)
# # http.ca_file = Rails.root.join(File.read('bgbilling.pem'))
# #http.key = OpenSSL::PKey::RSA.new(pem)
# response = http.request(Net::HTTP::Get.new(uri.path))
# p response
#   render json: response.body
#end
  render json: true
  end
end
