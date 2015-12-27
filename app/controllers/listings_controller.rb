class ListingsController < ApplicationController
  include ListingsHelper
  include HTTParty 
   

  def index

    #this code is what makes me able to sort based on certain values, will probably replace this with JS soon
    # sort_attribute = params[:input_sort]
    # @sort_order = params[:input_sort_order]

    # if params[:input_sort_order] == "asc"
    #   @new_sort_order = "desc"
    # else
    #   @new_sort_order = "asc"
    # end

    #  if params[:input_sort] && params[:input_sort_order]
    #   @listings = current_user.listings.order(sort_attribute => @sort_order)
    #  else
    #   @listings = current_user.listings.all
    #  end

    @listings = current_user.listings.all

  end

  def new
    @listing = Listing.new
  end

  def create

    inputs = defaults(params)

    @listing = Listing.new(
      user_id: current_user.id,
      address: inputs[:address],
      city: inputs[:city],
      state: inputs[:state],
      latitude: inputs[:latitude],
      longitude: inputs[:longitude],
      price: inputs[:price],
      zpid: inputs[:zpid],
      zip_code: inputs[:zipcode],
      bathrooms: inputs[:bathrooms],
      bedrooms: inputs[:bedrooms],
      sqft: inputs[:sqft],
      )

    if @listing.save 
      flash[:success] = "Listing successfully created!"
      redirect_to "/listings/#{@listing.id}/edit"
    end

  end


  def show
    @listing = Listing.find_by(id: params[:id])
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
