class CountersController < ApplicationController
  before_filter :authorize, only: [:index, :create]

  def index
    array = []
    @path = "http://izkh.ru/"
    @report = GetRequest.meters(1000, DateTime.now.month)
    if @report	
      @report.each do |r|
        array << r['user_account'].to_s
      end
      p @user_account = array.uniq
    end
  end

  def create
    @report = GetRequest.meters(1000, params[:month_id])
    @path = "http://izkh.ru/"
    data, array, @user_account = [], [], []
    if @report
      @report.each do |r|
        array << r['user_account'].to_s
      end
      p @user_account = array.uniq
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
