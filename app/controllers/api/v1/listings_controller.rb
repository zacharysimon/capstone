class Api::V1::ListingsController < ApplicationController
  include ListingsHelper

  def index
    if current_user
      @dashboard = current_user.get_dashboard
      @listings = current_user.listings.all
    end
  end

  def dashboard
    if current_user
      @dashboard = current_user.get_whole_dashboard
    end
  end
  
  def create

  end

  def zillow_search
    response = zillow_search_helper(params)

    hash_result = {
        results: response
      }

    render json: hash_result
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
  end

end