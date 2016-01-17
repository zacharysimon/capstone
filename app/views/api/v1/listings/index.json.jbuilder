json.listings do
  json.array! @listings do |listing|
    json.url listing.url
    json.id listing.id
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
    # json.debt_service listing.monthly_pmt(current_user)
    json.cost_per_sqft listing.cost_per_sqft
    json.rent_estimate listing.rent_estimate

    json.dashboard @dashboard do |heading|
      if !heading.nil?
        json.attribute_value listing.send(heading.characteristic.attribute_column_name)
        json.view_name heading.characteristic.attribute_view_name
      end
    end

  end
end

json.dashboard do 
  json.array! @dashboard do |heading|
    json.characteristic_id heading.characteristic_id
    json.order heading.order
    json.header_title heading.characteristic.attribute_view_name
    json.column_name heading.characteristic.attribute_column_name
  end   
end





