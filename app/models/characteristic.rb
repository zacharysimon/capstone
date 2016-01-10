class Characteristic < ActiveRecord::Base
  belongs_to :attributes_user
  belongs_to :user, though: :attributes_user
end
