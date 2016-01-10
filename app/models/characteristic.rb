class Characteristic < ActiveRecord::Base
  has_many :characteristics_users
  has_many :user, through: :characteristics_users



  def self.dashboard_headings(user)
     CharacteristicsUser.where("user_id LIKE ? AND visible LIKE ?", "%#{user.id}%", true)
  end

end
