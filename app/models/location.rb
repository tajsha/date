class Location < ActiveRecord::Base  
  attr_accessible :city, :latitude, :longitude, :zipcode, :zip_code
  scope :by_zip_code, ->(zipcode) { where('zipcode = ?', zipcode) }

end