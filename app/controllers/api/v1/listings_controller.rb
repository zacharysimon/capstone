class Api::V1::ListingsController < ApplicationController
  include ListingsHelper

  def index
    if current_user
      @dashboard = current_user.get_dashboard
      @listings = current_user.listings.all
    end
  end

  def dashboard
    @dashboard = current_user.get_whole_dashboard if current_user
  end

  def zillow_search
    response = zillow_search_helper(params)

    hash_result = { results: response }

    render json: hash_result
  end

  def update
    params["data"]["lists"].each_with_index do |attribute, index|
      visible = false
      visible = true if attribute["visible"] == "true"

      change_attribute = CharacteristicsUser.find_by(user_id: params["data"]["user"], characteristic_id: attribute['id'])
      change_attribute.update(visible: visible, order: index)
     end
  end

end