require 'rails_helper'

describe 'Listing API', type: :request do
  it 'sends all the listing' do 
    listing1 = Listing.create(
      address: "123 Street",
      city: "Chicago",
      state: "IL",
      price: "100")
    listing2 = Listing.create(
      address: "345 Street",
      city: "ChiTown",
      state: "IL",
      price: "300")

    get "/api/v1/listings", nil, \
      { 'HTTP_ACCEPT' => 'application/vnd.listings.v1' }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json[0]['address']).to eq listing1.address
  end
end