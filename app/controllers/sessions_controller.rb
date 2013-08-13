class SessionsController < ApplicationController

  def new
  end

  def create 
  	if  params[:auth_key] != ""  
      vendor = Vendor.where(:auth_key => params[:auth_key]).first
      if vendor
      session[:vendor_id] = vendor.id
        if session[:auth_token] = ""
          response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
          :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
          :headers => { 'Content-Type' => 'application/json' })
          @user = response.parsed_response["user"]["auth_token"]
          session[:auth_token] = @user
        end
      redirect_to transactions_url
    else
      render "new"
    end
    else 
      render "new"
    end
   end

   def destroy
     session[:vendor_id] = nil
     redirect_to root_url 
   end
end
