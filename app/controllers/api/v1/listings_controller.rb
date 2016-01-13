class Api::V1::ListingsController < ApplicationController

  def index
    if current_user
      @listings = current_user.listings.all
      @dashboard = current_user.get_dashboard
    end
  end

  def dashboard
    if current_user
      @dashboard = current_user.get_whole_dashboard
    end
  end
  
  def create

  end

  def update

    input_attributes = params["data"]["lists"]
    user = params["data"]["user"]

    i = 1
    input_attributes.each do |attribute|
        
      if attribute["visible"] == "true"
        visible = true
      else visible = false
      end

      change_attribute = CharacteristicsUser.find_by(user_id: user, characteristic_id: attribute['id'])

      change_attribute.update(visible: visible, order: i)
 
      i += 1
    end

    # redirect_to "../listings"
  end

end