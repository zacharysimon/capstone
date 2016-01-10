class Characteristic < ActiveRecord::Base
  has_many :characteristics_users
  has_many :user, through: :characteristics_users



  def self.dashboard_headings(user)
     CharacteristicsUser.where(user_id: user.id, visible: true).order(:order)
  end

  def self.all_dashboard_headings(user)
    CharacteristicsUser.where(user_id: user.id).order(:order)
  end

end
