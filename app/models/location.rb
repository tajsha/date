class Location < ActiveRecord::Base  
  attr_accessible :city, :latitude, :longitude, :zipcode, :zip_code
  has_and_belongs_to_many :users
  scope :by_zip_code, ->(zipcode) { where('zipcode = ?', zipcode) }

end