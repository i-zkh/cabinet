class CountersController < ApplicationController
  def index
  	p @report = GetRequest.meters(session[:vendor_id], DateTime.now.month)
    @path = "http://izkh.ru/"
  end

  def create
    @report = GetRequest.meters(session[:vendor_id], params[:month_id])
    @path = "http://izkh.ru/"
    respond_to do |f| f.js { render "counters/create" }
    end
  end
end
