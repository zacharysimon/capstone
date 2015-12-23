class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :comments 


  def full_address
    city 
  end


  def cost_per_sqft
    if price && sqft 
      return price / sqft 
    else
      return "Need more info"
    end
  end
end
