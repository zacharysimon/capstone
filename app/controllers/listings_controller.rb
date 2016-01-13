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
