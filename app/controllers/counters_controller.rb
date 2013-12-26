class CountersController < ApplicationController
  before_filter :authorize, only: [:index, :create]

  # Show vendor's meters from service in cabinet.
  def index
    array, field_title = [], []
    @path = "http://izkh.ru/"
    if session[:vendor_id] == 45
      @report = GetRequest.meters(1000, DateTime.now.month)
    else
      @report = GetRequest.meters(session[:vendor_id], DateTime.now.month)
    end
    if @report
      @report.each do |r|
        array << r['user_account'].to_s
        field_title << r['field_title']
      end
      @user_account = array.uniq
      @field_title = field_title.uniq
    end
  end

  def create
    if session[:vendor_id] == 45
      @report = GetRequest.meters(1000, params[:month_id])
    else
      @report = GetRequest.meters(session[:vendor_id], params[:month_id])
    end
    @path = "http://izkh.ru/"
    array, @user_account, field_title, @field_title = [], [], [], [], []
    if @report
      @report.each do |r|
        array << r['user_account'].to_s
        field_title << r['field_title']
      end
      @user_account = array.uniq
      @field_title = field_title.uniq
      if !params[:field_title].nil?
        data = []
        @report.each { |r| params[:field_title].each { |f| data << r if f == r['field_title'] }}
        @report = data
      end
      if params[:user_account] != ""
        data = []
        @report.each { |r| data << r if params[:user_account] == r['user_account'] } 
        @report = data
      end
    end
  end
end
