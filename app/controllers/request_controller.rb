#encoding: utf-8
class RequestController < ApplicationController
  def add_vendor_to_service
  	vendor = AddVendorToService.new("ЖСК 43", 4)
	  @vendor = vendor.add
    render json: @user
  end

  def request_tariff_template
    auth = session[:auth_token]
    tariff_template = CreateTariffTemplate.new("title", 105, 2, false, auth)
    @tariff_template = tariff_template.request
    render json: @tariff_template
  end

  def request_field_template
    auth = session[:auth_token]
    field_template = CreateFieldTemplate.new("title", 100.00, true, 200, "field_type", 'field_units', auth)
    @field_template = field_template.request
    render json: @field_template
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

end
