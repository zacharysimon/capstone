module ListingsHelper

  def zillow_get_deep_search_results(params)

    input_street_address = params[:address]
    input_city = params[:city]
    input_state = params[:state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")

    if response.parsed_response["searchresults"]["message"]["code"] != "508"

        if response.parsed_response["searchresults"]["response"]["results"]["result"].length > 0
            zillow_response = response.parsed_response["searchresults"]["response"]["results"]["result"][0]
        else
            zillow_response = response.parsed_response["searchresults"]["response"]["results"]["result"]
        end

        zpid = zillow_response["zpid"]
        latitude = zillow_response["address"]["latitude"]
        longitude = zillow_response["address"]["longitude"]
        price = zillow_response["zestimate"]["amount"]["__content__"]
        address = zillow_response["address"]["street"]
        city = zillow_response["address"]["city"]
        zipcode = zillow_response["address"]["zipcode"]
        state = zillow_response["address"]["state"]
        bathrooms = zillow_response["bathrooms"]
        bedrooms = zillow_response["bedrooms"]
        sqft = zillow_response["finishedSqFt"]
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

  def calulate_default_values(params)

    zillow = zillow_get_deep_search_results(params)

    if zillow[:zpid] == nil
        zpid = 0000
    else zpid = zillow[:zpid]
    end

    if zillow[:latitude] == nil
        latitude = 0000
    else latitude = zillow[:latitude]    
    end

    if zillow[:longitude] == nil
        longitude = 0000
    else longitude = zillow[:longitude]
    end 

    if zillow[:address] == nil
        address = params["address"].to_s
    else address = zillow[:address]
    end

    if zillow[:city] == nil
        city = params["city"].to_s
    else city = zillow[:city]   
    end

    if zillow[:state] == nil
        state = params["state"].to_s
    else state = zillow[:state]
    end 

    if params[:bedrooms] != nil 
        bedrooms = params[:bedrooms]
    elsif zillow[:bedrooms] != nil
        bedrooms = 0
    else bedrooms = zillow[:bedrooms]
    end 

    if zillow[:bathrooms] == nil
        bathrooms = 0
    else bathrooms = zillow[:bathrooms]
    end

    if zillow[:sqft] == nil
        sqft = 0
    else sqft = zillow[:sqft]    
    end

    if zillow[:zipcode] == nil
        zipcode = 00000
    else zipcode = zillow[:zipcode]
    end 
    if zillow[:price] == nil && params["price"] == ""
        price = 0
    elsif params["price"] != ""
        price = params["price"]
    else price = zillow[:price]
    end 
    if params[:tax_assessment] == nil
        tax_assessment = price * 0.011
    else tax_assessment = params[:tax_assessment]
    end
    if params[:hoa_assessment] == nil
        hoa_assessment = price * 0.0015
    else hoa_assessment = params[:hoa_assessment]
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
    tax_assessment: tax_assessment,
    hoa_assessment: hoa_assessment,
    }

  end

   


end
