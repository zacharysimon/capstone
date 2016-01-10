json.array! @listings do |listing|
  json.address listing.address
  json.zip_code listing.zip_code
  json.city listing.city
  json.state listing.state
  json.walk_score listing.walk_score
  json.transit_score listing.transit_score
  json.rent_estimate listing.rent_estimate 
  json.tax_assessment listing.tax_assessment
  json.sqft listing.sqft
  json.bathrooms listing.bathrooms
  json.price listing.price
  json.hoa_assessment listing.hoa_assessment
  json.debt_service listing.monthly_pmt(current_user)
end



