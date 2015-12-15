module ListingsHelper

  def zillow_get_deep_search_results(params)

    input_street_address = params[:input_street_address]
    input_city = params[:input_city]
    input_state = params[:input_state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")


    zpid = response["searchresults"]["response"]["results"]["result"][0]["zpid"]
    latitude = response["searchresults"]["response"]["results"]["result"][0]["address"]["latitude"]
    longitude = response["searchresults"]["response"]["results"]["result"][0]["address"]["longitude"]
    price = response["searchresults"]["response"]["results"]["result"][0]["zestimate"]["amount"]["__content__"]
    address = response["searchresults"]["response"]["results"]["result"][0]["address"]["street"]
    city = response["searchresults"]["response"]["results"]["result"][0]["address"]["city"]
    url = response["searchresults"]["response"]["results"]["result"][0]["links"]["homedetails"]
    zipcode = response["searchresults"]["response"]["results"]["result"][0]["address"]["zipcode"]
    state = response["searchresults"]["response"]["results"]["result"][0]["address"]["state"]
    bathrooms = response["searchresults"]["response"]["results"]["result"][0]["bathrooms"]
    bedrooms = response["searchresults"]["response"]["results"]["result"][0]["bedrooms"]
    sqft = response["searchresults"]["response"]["results"]["result"][0]["lotSizeSqFt"]
    yearbuilt = response["searchresults"]["response"]["results"]["result"][0]["yearBuilt"]
    lastdatesold = response["searchresults"]["response"]["results"]["result"][0]["lastSoldDate"]
    lastsoldprice = response["searchresults"]["response"]["results"]["result"][0]["lastSoldPrice"]
    hometype = response["searchresults"]["response"]["results"]["result"][0]["useCode"]

  {
    zpid: zpid,
    latitude: latitude,
    longitude: longitude,
    price: price,
    address: address,
    city: city,
    url: url,
    zipcode: zipcode,
    state: state
  }

  end

  def zillow_get_deep

end
