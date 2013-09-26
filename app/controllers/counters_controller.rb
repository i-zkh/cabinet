class CountersController < ApplicationController
  
  def index
    array = []
    params[:month_id] = DateTime.now.month
    @report = GetRequest.meters(session[:vendor_id], params[:month_id])
    if @report	
      @report.each do |r|
        array << r['user_account'].to_s
      end
      @user_account = array.uniq
    end
    @path = "http://izkh.ru/"
  end

  def create
    p @report = GetRequest.meters(session[:vendor_id], params[:month_id])
     @path = "http://izkh.ru/"
    data, array, @user_account = [], [], []
    if @report
      @report.each do |r|
        array << r['user_account'].to_s
      end
      @user_account = array.uniq
      if params[:user_account] != ""
        @report.each do |r|
          if params[:user_account] == r['user_account']
            data << r
          end
        end
        @report = data
      end
    end
  end
end
