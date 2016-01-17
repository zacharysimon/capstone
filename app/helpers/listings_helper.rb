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
    else zillow_response = [{"address": {"street": "No Zillow listings found. Click here to manually enter data."}}]
    end

    [zillow_response]      
  end


  def zillow_mortgage_helper(input_price, input_user)

    user = User.find_by(id: input_user)

    p user
    p input_price
    p user.percent_down_pmt

    if input_price != nil
      if user
        url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{input_price}&down=#{user.percent_down_pmt.to_i}"
      else
        # defaults to 20% downpayment
        url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{input_price}&down=20"
      end
    # if there is no price, defaults to $100,000
    else
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=100000&down=20"
    end

    response = HTTParty.get(url)

    mortgage_data = response.parsed_response["paymentsSummary"]["response"]["payment"]

    if user.loan_type == 30
      payment = mortgage_data[0]
    else 
      #sets default loan type to 15 yr fixed if a user isn't logged in
      payment = mortgage_data[1]
    end
    
    {monthly_pmt: payment["monthlyPrincipalAndInterest"]}
  
  end




end
