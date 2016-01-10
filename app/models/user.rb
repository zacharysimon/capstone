class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :listings
  has_many :comments 
  has_many :attributes_users
  has_many :characteristics, through: :attributes_users

  
end
