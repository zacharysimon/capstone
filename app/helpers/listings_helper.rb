module ListingsHelper

  $WS_APIKEY = "a6bc24ea405f37d3b976e634c478d688"
  $ZWS_ID = "X1-ZWz19ytk7im2ob_728x4"

  def walk_score_api(lat, long)
    response = HTTParty.get("http://api.walkscore.com/score?format=xml&lat=#{lat}&lon=#{long}&wsapikey=#{$WS_APIKEY}")

    { walk_score: response.parsed_response["result"]["walkscore"] }
  end

  def zillow_search_helper(params)

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=#{$ZWS_ID}&address=#{params[:address]}&citystatezip=#{params[:city]},#{params[:state]}")

     check_for_error = response.parsed_response["searchresults"]["message"]["code"]

    if check_for_error != "508" && check_for_error != "501" && check_for_error != "500"
        zillow_response = [response.parsed_response["searchresults"]["response"]["results"]["result"]]
    else zillow_response = [[{"address": {"street": "No Zillow listings found. Click here to manually enter data."}}]]
    end     
  end


  def zillow_mortgage_helper(input_price, input_user)
    user = User.find_by(id: input_user)

    if input_price != nil
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{input_price}&down=#{user.percent_down_pmt.to_i}"
    # if there is no price, defaults to $100,000
    else
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=100000&down=20"
    end

    mortgage_data = HTTParty.get(url).parsed_response["paymentsSummary"]["response"]["payment"]

    if user.loan_type == 30
      payment = mortgage_data[0]
    else  #sets default loan type to 15 yr fixed
      payment = mortgage_data[1]
    end
    
    {monthly_pmt: payment["monthlyPrincipalAndInterest"]}
  end




end
