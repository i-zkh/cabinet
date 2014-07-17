class SessionsController < ApplicationController
  def new
    if session[:vendor_id] == 3000
      redirect_to organization_add_vendors_path
    elsif session[:vendor_id]
      redirect_to transactions_url
    end
  end

  def create 
  	if  (params[:auth_key] != "") && (params[:email] != "")
      vendor = Vendor.where(:auth_key => params[:auth_key], :email => params[:email]).first
      if vendor.id == 3000
        session[:vendor_id] = vendor.id
        redirect_to organization_add_vendors_path
      elsif vendor
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