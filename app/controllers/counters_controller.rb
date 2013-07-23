class CountersController < ApplicationController
  def index
  	request = RequestMeter.new(1, DateTime.now.month)
	  @report = request.get_meter
    @path = "http://izkh.ru/"
  end

  def create
    request = RequestMeter.new(1, params[:month_id])
    @report = request.get_meter
    @path = "http://izkh.ru/"
    respond_to do |f| f.js { render "counters/create" }
    end
  end
end
