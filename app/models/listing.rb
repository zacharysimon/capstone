class Listing < ActiveRecord::Base
  include Finance

  belongs_to :user
  has_many :comments 

   
  def cost_per_sqft
    if price && sqft 
      return price / sqft 
    else
      return "Need more info"
    end
  end

  def neighborhood_score
    check = Comment.find_by(listing_id: id, comment_type: "neighborhood")
    if check
      return check.score
    else return ""
    end
  end

  def building_score
    check = Comment.find_by(listing_id: id, comment_type: "building")
    if check
      return check.score
    else return ""
    end
  end

  def layout_score
    check = Comment.find_by(listing_id: id, comment_type: "layout")
    if check
      return check.score
    else return ""
    end
  end

  def amenities_score
    check = Comment.find_by(listing_id: id, comment_type: "amenities")
    if check
      return check.score
    else return ""
    end
  end

  def rent_estimate
    if read_attribute(:rent_estimate) == nil
      return (0.008 * price).round(2)
    else
      return read_attribute(:rent_estimate)
    end
  end

  # def get_images
  #   response = HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19ytk7im2ob_728x4&zpid=#{zpid}")
  #   response.parsed_response["updatedPropertyDetails"]["response"]["images"]["image"]["url"]
  # end





  #below are methods for investing data, which will be secondary features once its all built

  def loan_stats(user)
    
    interest_rate = zillow_mortgage_api(User.first)["rate"]
    loan_amount = 250000

    if user.loan_type == 30
      rate = Rate.new(interest_rate, :apr, :duration => (30 * 12))
    else 
      rate = Rate.new(interest_rate, :apr, :duration => (15 * 12))
    end

    amortization = Amortization.new(loan_amount, rate)
    
    total_cost = amortization.payments.sum
    total_interest = amortization.interest.sum
    five_yr_interest = amortization.interest[0,60].sum
    five_yr_pmt = amortization.payments[0,60].sum
    five_yr_equity = five_yr_pmt - five_yr_interest

    return {
            "rate" => rate,
            "interest_rate" => interest_rate,
            "loan_amount" => loan_amount,
            "total_cost" => total_cost,
            "total_interest" => total_interest,
            "five_yr_interest" => five_yr_interest,
            "five_yr_pmt" => five_yr_pmt,
            "five_yr_equity" => five_yr_equity,
            }

  end

end
