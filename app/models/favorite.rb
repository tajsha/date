class Favorite < ActiveRecord::Base
  belongs_to :user
  has_many :users, :through => :user
end
