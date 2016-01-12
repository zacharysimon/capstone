class Api::V1::ListingsController < ApplicationController

  def index
    @listings = current_user.listings.all
    @dashboard = current_user.get_dashboard
  end

  def dashboard
    @dashboard = current_user.get_whole_dashboard
  end
  
  def create

  end

  def update

    input_attributes = params["lists"]
    p input_attributes
    
    input_attributes.each do |attribute|
      change_attribute = CharacteristicsUsers.where
    end


    

    # redirect_to "../listings"
  end

end