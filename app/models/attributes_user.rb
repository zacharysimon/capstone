class AttributesUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :characteristic
end
