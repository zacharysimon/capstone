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

    input_attributes = params["data"]["lists"]
    user = params["data"]["user"]
    p input_attributes
    p user
    p input_attributes[0]["id"]
    p input_attributes[0]["visible"]

    i = 1
    input_attributes.each do |attribute|
        
      if attribute["visible"] == "true"
        visible = true
      else visible = false
      end
      p visible

      change_attribute = CharacteristicsUser.find_by(user_id: user, characteristic_id: attribute['id'])

      p change_attribute

      
      change_attribute.update(visible: visible, order: i)
 
      i += 1
    end


    # redirect_to "../listings"
  end

end