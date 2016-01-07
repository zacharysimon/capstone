class Api::V1::ListingsController < ApplicationController

def index
  @listings = current_user.listings.all
end

end