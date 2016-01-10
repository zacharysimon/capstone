class Api::V1::ListingsController < ApplicationController

  def index
    @listings = current_user.listings.all
    @dashboard = current_user.get_dashboard
  end

  def dashboard
    @dashboard = current_user.get_whole_dashboard
  end
  
end