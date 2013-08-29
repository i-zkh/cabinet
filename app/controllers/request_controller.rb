require 'openssl'
require "net/https"
require "uri"
#encoding: utf-8
class RequestController < ApplicationController
  def add_vendor_to_service
  	PostRequest.vendor("test", 4)
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
  #  p response = HTTParty.get( "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%0034586&txn_date=20120827123230&sum=10.45&sign-md5=#{"ijkh.pem"}" )
  #  p @res = response.parsed_response
  #  render json: @res

  #  cert = OpenSSL::X509::Certificate.new(File.open("read.pem"))
  #p response = HTTParty.get( "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%0034586&txn_date=20120827123230&sum=10.45", {:ssl_client_cert => cert})
  #p @res = response.parsed_response
  # render json: @res
  
#  uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%0034586&txn_date=20120827123230&sum=10.45")
#  pem = File.read("ijkh.pem")
#  #pembg = File.read("bgbilling.pem")
#  http = Net::HTTP.new(uri.host, uri.port)
#  http.use_ssl = true
#  http.cert = OpenSSL::X509::Certificate.new(pem)
# # http.key = OpenSSL::PKey::RSA.new(pembg)
# # http.verify_mode = OpenSSL::SSL::VERIFY_PEER
#
#  p request = Net::HTTP::Get.new(uri.request_uri)

  uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=1%0034586&txn_date=20120827123230&sum=10.45")
  http = Net::HTTP.new(uri.host, uri.port)
  http.cert = OpenSSL::X509::Certificate.new(File.read("ijkh.pem"))
  request = Net::HTTP::Get.new(uri.request_uri)
  p request.body

  render json: true
  end
end
