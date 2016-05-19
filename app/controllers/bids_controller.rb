class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # view all bids
  def index
    if params[:sort]
      @bids = Bid.where(:user_id => current_user.id).order(params[:sort] + ' DESC')
    else
      @bids = Bid.where(:user_id => current_user.id)
    end
  end

  # view a bid
  def show
    @listing = params[:listing]
    @bid = Bid.find(params[:id])
  end

  def accept
    @bid = Bid.find(params[:id])
    if @bid.user_id == current_user.id
      respond_to do |format|
        format.html { render 'show', notice: 'You do not have permission.' }
      end
    else
      @bid.accepted = true
      @listing = Listing.find(params[:listing])
      @listing.accepted = true
      @listing.save
      @bid.save
      redirect_to :action => 'index', :controller => 'bids'
    end
  end

  # start a new bid
  def new
    @listing = params[:listing]
    if Listing.find(@listing).user_id == current_user.id
      redirect_to listings_path, notice: 'You cannot bid on your own listing.'
    else
      @bid = Bid.new
    end
  end

  # actually create it
  def create
    @bid = Bid.new(bid_params)
    @listing = params[:listing]
    if Listing.find(@listing).price > @bid.bid_price
      render :new, notice: 'Please create a bid price higher than the asking price.'
    else
      @listing = Listing.find(@listing)
      @listing.bid_quantity += 1
      @listing.save
      update_price(@listing, @bid, 'add')
      @bid.listing_id = @listing.id
      @bid.user_id = current_user.id
      @bid.accepted = false
      @bid.save

      respond_to do |format|
        if @bid.save
          format.html { redirect_to @bid, notice: 'Your bid was successfully created.' }
          format.json { render :show, status: :created, location: @bid }
        else
          format.html { render :new }
          format.json { render json: @bid.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update_price(listing, bid, action)
    if listing.bid_quantity == 0
      listing.average_price = listing.price
    elsif listing.bid_quantity == 1
      listing.average_price = bid.bid_price
    else
      case action
      when 'add'
        listing.average_price*=(listing.bid_quantity-1)
        listing.average_price+=bid.bid_price
        listing.average_price/=listing.bid_quantity
      when 'remove'
        listing.average_price*=(listing.bid_quantity+1)
        listing.average_price-=bid.bid_price
        listing.average_price/=listing.bid_quantity
      end
    end
    listing.save
  end

  # remove the bid
  def destroy
    if @bid.user_id == current_user.id
      @listing = Listing.find(@bid.listing_id)
      @listing.bid_quantity -= 1
      @listing.save
      update_price(@listing, @bid, 'remove')
      @bid.destroy
      respond_to do |format|
        format.html { redirect_to bids_url, notice: 'Your bid was successfully removed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to bids_url, notice: 'You do not have permission to remove this from bids.' }
        format.json { head :no_content }
      end
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
