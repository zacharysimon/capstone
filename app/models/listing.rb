class Listing < ActiveRecord::Base
  include Finance

  belongs_to :user
  has_many :comments 


  def zillow_mortgage_api(user)
    if price != nil
      if user
        url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{price}&down=#{user.percent_down_pmt.to_i}"
      else
        # defaults to 20% downpayment
        url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=#{price}&down=20"
      end
    # if there is no price, defaults to 100000
    else
      url = "http://www.zillow.com/webservice/GetMonthlyPayments.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&price=100000&down=20"
    end

    response = HTTParty.get(url)

    if user.loan_type == 30
      return response.parsed_response["paymentsSummary"]["response"]["payment"][0]
    else 
      return response.parsed_response["paymentsSummary"]["response"]["payment"][1]
    end
  end

  def cost_per_sqft
    if price && sqft 
      return price / sqft 
    else
      return "Need more info"
    end
  end

  def monthly_pmt(user)
    monthly_pmt = zillow_mortgage_api(user)["monthlyPrincipalAndInterest"]
  end

  def rent_estimate
    if read_attribute(:rent_estimate) == nil
      return 0.008 * price 
    else
      return read_attribute(:rent_estimate)
    end
  end


  #below are methods for investing data, which will be secondary features once its all built

  def total_interest(user)
    
    interest_rate = zillow_mortgage_api(User.first)["rate"]
    loan_amount = price * (1 - (user.percent_down_pmt / 100))

    if user.loan_type == 30
      rate = Rate.new(interest_rate, :apr, :duration => (30 * 12))
    else 
      rate = Rate.new(interest_rate, :apr, :duration => (15 * 12))
    end

    amortization = Amortization.new(loan_amount, rate)
    return amortization.interest.sum
  end

  def five_yr_equity (user)
    loan_amount = price * (1 - (user.percent_down_pmt / 100))
    rate = Rate.new( :apr, :duration => (30*12))
    amortization = Amortization.new(loan_amount, rate)

    five_yr_interest = amortization.interest[0,72].sum
    five_yr_pmt = amortization.payments[0,72].sum
    return five_yr_pmt - five_yr_interest + (price - loan_amount)
  end

end
