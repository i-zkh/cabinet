#encoding: UTF-8
class AccountsController < ApplicationController

  def account
    @account = Account.where('vendor_id = ? AND user_account = ?', params[:vendor_id], params[:user_account])
    if @account == []
      Account.where('vendor_id = ?', params[:vendor_id]) == [] ? status = -1 : status = 0
    else
      status = 1
    end
    render json: { status: status }
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