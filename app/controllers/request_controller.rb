#encoding: utf-8
class RequestController < ApplicationController

  def auth_token
    response = HTTParty.post( "http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com/users/sign_in.json",
      :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
      :headers => { 'Content-Type' => 'application/json' })
    @user = response.parsed_response["user"]["auth_token"]
  end

  def request_vendor
    auth = session[:auth_token]
  	vendor = CreateVendor.new("ЖСК 43", 4, auth)
	  @vendor = vendor.request
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

end
