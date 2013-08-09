class SessionsController < ApplicationController

  def new
  end

  def create 
  	if  params[:auth_key] != ""  
      vendor = Vendor.where(:auth_key => params[:auth_key]).first
      if vendor
      session[:vendor_id] = vendor.id
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
