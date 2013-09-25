class CountersController < ApplicationController
  def work_counters
    array = []
    params[:month_id] = DateTime.now.month
    @report = GetRequest.meters(1000, params[:month_id])
    if @report	
      @report.each do |r|
        array << r['user_id'].to_s
      end
      @user_account = array.uniq
    end
    @path = "http://izkh.ru/"
  end

  def create
    p @report = GetRequest.meters(1000, params[:month_id])
     @path = "http://izkh.ru/"
    data, array = [], []
    @user_account = []
    if @report
      @report.each do |r|
        array << r['user_id'].to_s
      end
      @user_account = array.uniq
      if params[:user_account] != ""
        @report.each do |r|
          if params[:user_account].to_i == r['user_id']
            data << r
          end
        end
        @report = data
      end
    end
  end
end
