class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :listings
  has_many :comments 
  has_many :characteristics_users
  has_many :characteristics, through: :characteristics_users


  def get_dashboard
    Characteristic.dashboard_headings(self)
  end

  def get_whole_dashboard
    Characteristic.all_dashboard_headings(self)
  end

end
