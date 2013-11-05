class CountersController < ApplicationController
  before_filter :authorize, only: [:index, :create]

  def index
    array = []
    @path = "http://izkh.ru/"
    if session[:vendor_id] == 45
      @report = GetRequest.meters(1000, DateTime.now.month)
    else
      @report = GetRequest.meters(session[:vendor_id], DateTime.now.month)
    end
    if @report
      @report.each do |r|
        array << r['user_account'].to_s
      end
      @user_account = array.uniq
    end
  end

  def create
    if session[:vendor_id] == 45
      p @report = GetRequest.meters(1000, params[:month_id])
    else
      @report = GetRequest.meters(session[:vendor_id], params[:month_id])
    end
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
