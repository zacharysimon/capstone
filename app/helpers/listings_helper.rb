module ListingsHelper

  def walk_score_api(zillow_lat, zillow_lon)

    input_lat = zillow_lat
    input_lon = zillow_lon

    response = HTTParty.get("http://api.walkscore.com/score?format=xml&lat=#{input_lat}&lon=#{input_lon}&wsapikey=a6bc24ea405f37d3b976e634c478d688")

    walk_score = response.parsed_response["result"]["walkscore"]

    {
        walk_score: walk_score
    }
  end

  def zillow_get_deep_search_results(params)

    input_street_address = params[:address]
    input_city = params[:city]
    input_state = params[:state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_street_address}&citystatezip=#{input_city},#{input_state}")

    check_for_error = response.parsed_response["searchresults"]["message"]["code"]

    if check_for_error != "508" && check_for_error != "501"

        if response.parsed_response["searchresults"]["response"]["results"]["result"].length > 1
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
    walk_score = walk_score_api(zillow[:latitude], zillow[:longitude])

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
        bedrooms = zillow[:bedrooms]
    else bedrooms = 0
    end 

    if params[:bathrooms] != nil
        bathrooms = params[:bathrooms]
    elsif zillow[:bathrooms] != nil
        bathrooms = zillow[:bathrooms]
    else bathrooms = params[:bathrooms]
    end

    if walk_score[:walk_score] == nil
        walk_score = 1
    else walk_score = walk_score[:walk_score]
    end

    if zillow[:sqft] == nil
        sqft = 1
    else sqft = zillow[:sqft]    
    end

    if zillow[:zipcode] == nil
        zipcode = 00000
    else zipcode = zillow[:zipcode]
    end 
    if zillow[:price] == nil && params["price"] == ""
        price = 1
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
    monthly_debt_service = 


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
    walk_score: walk_score,
    #add monthly payment here
    }

  end

   


end
