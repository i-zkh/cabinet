class UserCheckController < ApplicationController

  # Service find user amount in service
  def address
  	@vendor = Vendor.where("title = ?", params[:title]).first
    @address_check = Account.where("city = ? AND street = ? AND building = ? AND apartment = ? AND vendor_id = ?", params[:city], params[:street], params[:building], params[:apartment], @vendor.id).first

    unless @address_check.nil?
      @payload = Payload.where(user_id: @address_check.id, user_type: "AddressRange").first
      render json: @payload.invoice_amount
    else
      render json: false
    end
  end

  def account
  	@vendor = Vendor.where("title = ?", params[:title]).first
  	@user_check = Account.where("user_account = ? AND vendor_id = ?", params[:user_account], @vendor.id).first
  	unless @user_check.nil?
  		@payload = Payload.where(user_id: @user_check.id, user_type: "UserIdRange").first
  		render json: @payload.invoice_amount
  	else
  		render json: false
  	end
  end
end
