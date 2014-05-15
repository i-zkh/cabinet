class MetersController < ApplicationController
  def index
  	array, @from, @to = [], Date.today.beginning_of_month, Date.today.end_of_month
  	@report = GetRequest.utility_metrics(session[:vendor_id], @from, @to)
    # @report.each {|r| array << r['user_id'].to_s} 
    @report = []
    @user = array.uniq
  end

  def create
  	array = []
    @from = params[:from] != "" ? params[:from] : Date.today.beginning_of_month
    @to = params[:to] != "" ? params[:to] : Date.today.end_of_month
  	@report = GetRequest.utility_metrics(session[:vendor_id], @from, @to)
    @report.each {|r| array << r['user_id'].to_s}
    @user = array.uniq
  	if params[:user_address] != ""
        data = []
        @report.each {|r| data << r if params[:user_address] == r['user_id'].to_s} 
        @report = data
    end
  end

  def save_metrics_process
    PostRequest.metrics_process(params["utility_metrics"])
    redirect_to meters_url 
  end
end
