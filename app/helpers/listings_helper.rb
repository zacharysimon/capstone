module ListingsHelper

  def zillow_get_deep_search_results(params)

    input_street_address = params[:address]
    input_city = params[:city]
    input_state = params[:state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")

    if response.parsed_response["searchresults"]["message"]["code"] != "508"
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
    end

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

  def defaults(params)
    zillow = zillow_get_deep_search_results(params)

    if zillow["zpid"] == nil
        zpid = 0000
    else zpid = zillow["zpid"]
    end

    if zillow["latitude"] == nil
        latitude = 0000
    else latitude = zillow["latitude"]    
    end

    if zillow["longitude"] == nil
        longitude = 0000
    else longitude = zillow["longitude"]
    end 

    if zillow["address"] == nil
        address = params[:address].to_s
    else address = zillow["address"]
    end

    if zillow["city"] == nil
        city = params[:city].to_s
    else city = zillow["city"]   
    end

    if zillow["state"] == nil
        state = params[:state].to_s
    else state = zillow["state"]
    end 

    if zillow["bedrooms"] == nil
        bedrooms = 0
    else bedrooms = zillow["bedrooms"]
    end 

    if zillow["bathrooms"] == nil
        bathrooms = 0
    else bathrooms = zillow["bathrooms"]
    end

    if zillow["sqft"] == nil
        sqft = 0
    else sqft = zillow["sqft"]    
    end

    if zillow["zipcode"] == nil
        zipcode = 00000
    else zipcode = zillow["zipcode"]
    end 
    if zillow["price"] == nil
        price = params[:price]
    else price = zillow["price"]
    end 

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
