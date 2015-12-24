class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :comments 

  # def cleanse_attributes(params)
  #   if(params[:rent_zestimate])
  # end

  def cost_per_sqft
    if price && sqft 
      return price / sqft 
    else
      return "Need more info"
    end
  end

  def monthly_pmt(user)

    if user
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{price}&down=#{user.percent_down_pmt.to_i}"
    else
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{price}&down=30"
    end

    response = HTTParty.get(url)

    if user.loan_type == 30
      return response.parsed_response["paymentsSummary"]["response"]["payment"][0]["monthlyPrincipalAndInterest"]
    else 
      return response.parsed_response["paymentsSummary"]["response"]["payment"][1]["monthlyPrincipalAndInterest"]
    end

  end

  def rent_zestimate
    if read_attribute(:rent_zestimate) == nil
      return 0.8 * price 
    else
      return read_attribute(:rent_zestimate)
    end
  end

end
