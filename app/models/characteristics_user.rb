class CharacteristicsUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :characteristic
  

end
