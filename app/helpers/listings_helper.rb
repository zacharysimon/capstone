module ListingsHelper

  def zillow_get_search_results(params)

    input_street_address = params[:input_street_address]
    input_city = params[:input_city]
    input_state = params[:input_state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")


    zpid = response.parsed_response["searchresults"]["response"]["results"]["result"]["zpid"]
    
    latitude = response.parsed_response["searchresults"]["response"]["results"]["result"]["address"]["latitude"]
    longitude = response.parsed_response["searchresults"]["response"]["results"]["result"]["address"]["longitude"]
    price = response.parsed_response["searchresults"]["response"]["results"]["result"]["zestimate"]["amount"]["__content__"]

  {
    zpid: zpid,
    latitude: latitude,
    longitude: longitude,
    price: price 
  }

  end

end
