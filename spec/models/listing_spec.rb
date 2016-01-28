require 'rails_helper'

describe Listing do 
  it "is valid with an Address, City, and State" do 
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago",
      state: "IL")
    expect(listing).to be_valid
  end

  it "is invalid with no Address" do
    listing = Listing.new( 
      address: "123 Street",
      state: "IL")
    listing.valid? 
    expect(listing.errors[:city]).to include("can't be blank")
  end

  it "is invalid with no City" do
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago")
    listing.valid? 
    expect(listing.errors[:state]).to include("can't be blank")
  end

end