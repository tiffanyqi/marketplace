class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    @listing = params[:listing]
    @bid = Bid.find(params[:id])
  end

  # GET /bids/new
  def new
    @bid = Bid.new
    @listing = params[:listing]
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @listing = Listing.find(params[:listing])
    if @listing.bid_quantity == 1
      @listing.average_price = @bid.bid_price
    else
      @listing.average_price = (@listing.average_price * @listing.bid_quantity + @bid.bid_price)
      @listing.average_price = @listing.average_price / (@listing.bid_quantity + 1)
    end
    @listing.bid_quantity += 1
    @bid.listing_id = @listing
    @bid.user_id = current_user.id
    @bid.save
    @listing.save

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:listing_id, :user_id, :bid_price)    
    end
end
