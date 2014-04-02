class BidsController < ApplicationController
  # GET /bids
  # GET /bids.json
  def index
    @from = !params[:from].nil? ? params[:from] : Date.today.beginning_of_month
    @to = !params[:to].nil? ? params[:to] : Date.today.end_of_month
    @bids = Bid.where(created_at: @from..@to)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bids }
    end
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    @bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bid }
    end
  end

  # GET /bids/new
  # GET /bids/new.json
  def new
    @bid = Bid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bid }
    end
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(params[:bid])
    respond_to do |format|
      if @bid.save
        DeltaWorker.perform_async(@bid)
        format.html { redirect_to @bid, notice: 'Заявка отправлена клиенту' }
        format.json { render json: @bid, status: :created, location: @bid }
      else
        format.html { render action: "new" }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

end
