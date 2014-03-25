#encoding: UTF-8
class AccountsController < ApplicationController

  def account
    @accounts = Account.where('vendor_id = ?', params[:vendor_id])
	@vendor = Vendor.find(params[:vendor_id])
  end
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to :back
  end

  def update
	render json: true
  end
end