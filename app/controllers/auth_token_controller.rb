class AuthTokenController < ApplicationController
  def create 
  	response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
      :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
      :headers => { 'Content-Type' => 'application/json' })
    @user = response.parsed_response["user"]["auth_token"]

    session[:auth_token] = @user
    render json: @user
  end
end
