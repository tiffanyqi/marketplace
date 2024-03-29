class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:sell, :new, :edit, :create, :update, :destroy]

  # display all listings, the main "buy" page.
  def index
    @listings = Listing.order(params[:sort])
  end

  # manage own listings.
  def sell
    if params[:sort]
      @listings = Listing.where(:user_id => current_user.id).order(params[:sort] + ' DESC')
    else
      @listings = Listing.where(:user_id => current_user.id)
    end
  end

  # more information about the listing
  def show
    @listing = Listing.find(params[:id])
    if params[:sort]
      @bids = Bid.where(:listing_id => @listing).order(params[:sort] + ' DESC')
    else
      @bids = Bid.where(:listing_id => @listing)
    end
  end

  # set up the new listing
  def new
    @listing = Listing.new
  end

  # edit an existing listing
  def edit
    if @listing.user_id != current_user.id
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'You do not have permission to access this.' }
        format.json { head :no_content }
      end
    end
  end

  # create the new listing as supplied by "new"
  def create
    @listing = Listing.new(listing_params)
    @listing.bid_quantity = 0
    @listing.average_price = @listing.price
    @listing.user_id = current_user.id
    @listing.accepted = false
    # @listing.user = current_user.first_name + " " + current_user.last_name
    @listing.save

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Your listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # updating a listing from edit.
  def update
    respond_to do |format|
      if @listing.user_id == current_user.id
        if @listing.update(listing_params)
          format.html { redirect_to @listing, notice: 'Your listing was successfully updated.' }
          format.json { render :show, status: :ok, location: @listing }
        end
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    if @listing.user_id == current_user.id
      @listing.destroy
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'Your listing was successfully removed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'You do not have permission to remove this from listings.' }
        format.json { head :no_content }
      end
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :bid_quantity, :price, :average_price, :user_id, :bids, :image)
    end
end
