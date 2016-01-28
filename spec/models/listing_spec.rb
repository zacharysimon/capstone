require 'rails_helper'

describe Listing do 
  it "is valid with an Address, City, and State" do 
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago",
      state: "IL",
      price: "100")
    expect(listing).to be_valid
  end

  it "is invalid with no Address" do
    listing = Listing.new( 
      address: "123 Street",
      state: "IL",
      price: "100")
    listing.valid? 
    expect(listing.errors[:city]).to include("can't be blank")
  end

  it "is invalid with no City" do
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago",
      price: "100")
    listing.valid? 
    expect(listing.errors[:state]).to include("can't be blank")
  end

  it "requires uniqueness for addresses for the same user" do
  end

  it "requires a listing to have a price" do 
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago",
      state: "IL")
    listing.valid? 
    expect(listing.errors[:price]).to include("can't be blank")
  end

  it "requires a listing to have a numeric price" do 
    listing = Listing.new( 
      address: "123 Street",
      city: "Chicago",
      state: "IL",
      price: "asdfasd")
    listing.valid? 
    expect(listing.errors[:price]).to include("is not a number")
  end

end