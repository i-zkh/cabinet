class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  def current_user
  	@current_user ||= Vendor.find(session[:vendor_id]) if session[:vendor_id]
  end
  helper_method :current_user

  def authorize
  	redirect_to new_session_path if current_user.nil?
  end

  def session_auth 
    response = HTTParty.post( "https://izkh.ru/users/sign_in.json",
    :body => { :user =>  { :email => "iva.anastya@gmail.com", :password => "slastenka3677" }}.to_json,
    :headers => { 'Content-Type' => 'application/json' })
    @user = response.parsed_response["user"]["auth_token"]
    session[:auth_token] = @user
	  @session_auth = session[:auth_token]
  end
  helper_method :session_auth
  
end
