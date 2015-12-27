module ListingsHelper

  def zillow_get_deep_search_results(params)

    input_street_address = params[:address]
    input_city = params[:city]
    input_state = params[:state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")

    zpid = response["searchresults"]["response"]["results"]["result"]["zpid"]
    latitude = response["searchresults"]["response"]["results"]["result"]["address"]["latitude"]
    longitude = response["searchresults"]["response"]["results"]["result"]["address"]["longitude"]
    price = response["searchresults"]["response"]["results"]["result"]["zestimate"]["amount"]["__content__"]
    address = response["searchresults"]["response"]["results"]["result"]["address"]["street"]
    city = response["searchresults"]["response"]["results"]["result"]["address"]["city"]
    zipcode = response["searchresults"]["response"]["results"]["result"]["address"]["zipcode"]
    state = response["searchresults"]["response"]["results"]["result"]["address"]["state"]
    bathrooms = response["searchresults"]["response"]["results"]["result"]["bathrooms"]
    bedrooms = response["searchresults"]["response"]["results"]["result"]["bedrooms"]
    sqft = response["searchresults"]["response"]["results"]["result"]["finishedSqFt"]
    hometype = response["searchresults"]["response"]["results"]["result"]["useCode"]


  {
    zpid: zpid,
    latitude: latitude,
    longitude: longitude,
    price: price,
    address: address,
    city: city,
    zipcode: zipcode,
    state: state,
    bathrooms: bathrooms,
    bedrooms: bedrooms,
    sqft: sqft,
  }
  end

  

   


end
