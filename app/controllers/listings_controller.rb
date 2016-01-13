class ListingsController < ApplicationController
  include ListingsHelper
  include HTTParty 
  
  def home 
    if current_user
      unless CharacteristicsUser.where(user_id: current_user.id).exists? 
        i = 1
        vis = true
        Characteristic.all.each do |char|
          CharacteristicsUser.create(
            user_id: current_user.id,
            characteristic_id: char.id,
            order: i,
            visible: vis,
            )
          i += 1
          vis = !vis
        end
      end
    end
  end 

  def index
    @listings = current_user.listings.all
  end

  def new
    @listing = Listing.new
  end

  def create

    inputs = calulate_default_values(params)

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
      hoa_assessment: inputs[:hoa_assessment],
      tax_assessment: inputs[:tax_assessment],
      walk_score: inputs[:walk_score]
      )

    p inputs[:tax_assessment]
    p inputs[:hoa_assessment]

    if @listing.save 
      flash[:success] = "Listing successfully created!"
      redirect_to "/listings"
    end

  end


  def show
    @listing = Listing.find_by(id: params[:id])
  end

  def edit
    if current_user
      @listing = Listing.find_by(id: params[:id])
    end
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
