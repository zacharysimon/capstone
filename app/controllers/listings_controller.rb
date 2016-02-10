class ListingsController < ApplicationController
  # include ZillowApi
  include HTTParty 
  include ListingsHelper

  
  def home 

    if current_user #redirects to index if there is a current user, and sets defaults
      unless CharacteristicsUser.where(user_id: current_user.id).exists? 
        Characteristic.all.each do |char|
          CharacteristicsUser.create(
            user_id: current_user.id,
            characteristic_id: char.id,
            order: char.default_order,
            visible: char.default_visible
            )
        end

        current_user.update(loan_type: 15, percent_down_pmt: 20.00)
      end

      redirect_to "/listings"
    end
  end 

  def index
    redirect_to '/' unless current_user
  end

  def new
    @listing = Listing.new
  end

  def create

    input_walk_score = walk_score_api(params[:latitude], params[:longitude])
    monthly_pmt = zillow_mortgage_helper(params["price"], params["user_id"])

    @listing = Listing.new(
      user_id: params["user_id"],
      address: params["address"],
      city: params["city"],
      state: params["state"],
      latitude: params["latitude"],
      longitude: params["longitude"],
      price: params["price"],
      zpid: params["zpid"],
      zip_code: params["zip_code"],
      bathrooms: params["bathrooms"],
      bedrooms: params["bedrooms"],
      sqft: params["sqft"],
      hoa_assessment: params["hoa_assessment"],
      tax_assessment: params["tax_assessment"],
      walk_score: input_walk_score[:walk_score],
      monthly_debt_service: monthly_pmt[:monthly_pmt],
      url: params["url"]
      )

    if @listing.save 
      flash[:success] = "Listing successfully created!"
      render text: "OK", status: 200
    end

  end


  def show
    #need to refactor so someone not signed in doesn't get an error heres
    @listing = Listing.find_by(id: params[:id]) if current_user
  end

  def edit
    @listing = Listing.find_by(id: params[:id]) if current_user
  end

  def update
    if current_user
      @listing = Listing.find_by(id: params[:id])
      if @listing.update(
        address: params[:input_address],
        city: params[:input_city],
        state: params[:input_state],
        price: params[:input_price],
        bathrooms: params[:input_bathrooms],
        bedrooms: params[:input_bedrooms],
        sqft: params[:input_sqft],
        hoa_assessment: params[:input_hoa_assessment],
        tax_assessment: params[:input_tax_assessment],
        walk_score: params[:input_walk_score],
        url: params[:input_url]
        )
       flash[:success] = "Listing was successfully updated!"
       redirect_to "/listings/#{@listing.id}"
      else 
        render :edit
      end
    end
  end

  def destroy
    listing_to_delete = Listing.find_by(id: params[:id])
    listing_to_delete.delete

    flash[:success] = "listing successfully deleted!"
    redirect_to '/listings'
  end

end
