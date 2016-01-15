module ListingsHelper

  def walk_score_api(lat, long)

    input_lat = lat
    input_lon = long

    response = HTTParty.get("http://api.walkscore.com/score?format=xml&lat=#{input_lat}&lon=#{input_lon}&wsapikey=a6bc24ea405f37d3b976e634c478d688")

    walk_score = response.parsed_response["result"]["walkscore"]

    {
        walk_score: walk_score
    }
  end

  def zillow_search_helper(params)
    input_address = params[:address]
    input_city = params[:city]
    input_state = params[:state]

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&address=#{input_address}&citystatezip=#{input_city},#{input_state}")

     check_for_error = response.parsed_response["searchresults"]["message"]["code"]

    if check_for_error != "508" && check_for_error != "501" && check_for_error != "500"
        zillow_response = response.parsed_response["searchresults"]["response"]["results"]["result"]
    else zillow_response = [{"address": {"street": "No existing listings found. Click here to manually enter data."}}]
    end

    [zillow_response]      
  end

end
