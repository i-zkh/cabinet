class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  def current_user
  	@current_user ||= Vendor.find(session[:vendor_id]) if session[:vendor_id]
  end
  helper_method :current_user

  def authorize
  	redirect_to new_session_path if (current_user.nil? && current_user.id != vendor.id)
  end
end
