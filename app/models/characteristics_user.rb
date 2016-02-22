class CharacteristicsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :characteristic
  
  def self.create_new_dashboard(user)
    Characteristic.all.each do |char|
      CharacteristicsUser.create(
        user_id: user.id,
        characteristic_id: char.id,
        order: char.default_order,
        visible: char.default_visible
        )
    end
  end
  

  
end
