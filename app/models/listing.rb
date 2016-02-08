class Listing < ActiveRecord::Base
  include Finance

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :price, presence: true, numericality: true

  belongs_to :user
  has_many :comments 
   
  def cost_per_sqft
    cost_per_sqft = ""

    if price && sqft 
      cost_per_sqft = price / sqft 
    end

    cost_per_sqft
  end

  def find_comment_score(input)
    comment = Comment.find_by(listing_id: id, comment_type: input)

    if !comment 
      score = ""
    else score = comment.score 
    end

    score    
  end

  def neighborhood_score
    find_comment_score("Neighborhood")
  end

  def building_score
    find_comment_score("Building")
  end

  def layout_score
    find_comment_score("Layout")
  end

  def amenities_score
    find_comment_score("Amenities")
  end

  def rent_estimate
    rent_est = read_attribute(:rent_estimate)

    if rent_est == nil
      rent_est = (0.008 * price).round(2) 
    end

    rent_est
  end


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
