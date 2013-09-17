class CountersController < ApplicationController
  def index
  	@report = GetRequest.meters(1000, DateTime.now.month)
    @path = "http://izkh.ru/"
  end

  def create
    @report = GetRequest.meters(1000, params[:month_id])
    @path = "http://izkh.ru/"
    respond_to do |f| f.js { render "counters/create" }
    end
  end
end
