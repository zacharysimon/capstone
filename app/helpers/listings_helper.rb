module ListingsHelper

  $WS_APIKEY = "a6bc24ea405f37d3b976e634c478d688"
  $ZWS_ID = "X1-ZWz19ytk7im2ob_728x4"

  def get_api_data(params)
    walk_score = walk_score_api(params)
    monthly_pmt = zillow_mortgage_helper(params)

    { walk_score: walk_score, monthly_pmt: monthly_pmt}
  end

  def walk_score_api(params)
    lat = params[:latitude]
    long = params[:longitude]

    response = HTTParty.get("http://api.walkscore.com/score?format=xml&lat=#{lat}&lon=#{long}&wsapikey=#{$WS_APIKEY}")

    response.parsed_response["result"]["walkscore"]
  end

  def zillow_search_helper(params)

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=#{$ZWS_ID}&address=#{params[:address]}&citystatezip=#{params[:city]},#{params[:state]}")

    if check_for_error(response) == "No error"
        zillow_response = { results: [response.parsed_response["searchresults"]["response"]["results"]["result"]]}
    else zillow_response = { results: [[{"address": {"street": "No Zillow listings found. Click here to manually enter data."}}]] }
    end     
  end

  def check_for_error(raw_response)
    check = raw_response.parsed_response["searchresults"]["message"]["code"]

    return "No error" if check != "508" && check != "501" && check != "500"
  end

  def zillow_mortgage_helper(params)

    input_price = params["price"]
    user = User.find_by(id: params["user_id"])

    if input_price != nil
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{input_price}&down=#{user.percent_down_pmt.to_i}"
    else     # if there is no price, defaults to $100,000
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=100000&down=20"
    end

    mortgage_data = HTTParty.get(url).parsed_response["paymentsSummary"]["response"]["payment"][user_loan_preference(params)]["monthlyPrincipalAndInterest"]
  end

  def user_loan_preference(params)
    user = User.find_by(id: params["user_id"])

    if user.loan_type == 30
      return 0
    else return 1 
    end
  end



end
