class ListingsController < ApplicationController
  include ListingsHelper
  include HTTParty 
  def home
  end

  def index
    sort_attribute = params[:input_sort]
    @sort_order = params[:input_sort_order]

    if params[:input_sort_order] == "asc"
      @new_sort_order = "desc"
    else
      @new_sort_order = "asc"
    end

     if params[:input_sort] && params[:input_sort_order]
      @listings = current_user.listings.order(sort_attribute => @sort_order)
     else
      @listings = current_user.listings.all
     end

  end

  def create
    response = zillow_get_deep_search_results(params)

    p response 

    @listing = Listing.new(
      user_id: current_user.id,
      street_adress: response[:address],
      city: response[:city],
      state: response[:state],
      latitude: response[:latitude],
      longitude: response[:longitude],
      price: response[:price],
      zpid: response[:zpid],
      zip_code: response[:zipcode],
      url: response[:url],
      lastdatesold: response[:lastdatesold],
      lastsoldprice: response[:lastsoldprice],
      bathrooms: response[:bathrooms],
      bedrooms: response[:bedrooms],
      sqft: response[:sqft],
      home_type: response[:hometype],
      yearbuilt: response[:yearbuilt],
      )

    if @listing.save 
      flash[:success] = "Listing successfully created!"
      redirect_to '/listings'
    else
      render :index
    end

  end

  def new
    @listing = Listing.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    listing_to_delete = Listing.find_by(id: params[:id])
    listing_to_delete.delete

    flash[:success] = "listing successfully deleted!"
    redirect_to '/listings'
  end

end
