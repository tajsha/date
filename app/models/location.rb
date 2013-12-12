class Location < ActiveRecord::Base  
  attr_accessible :city, :latitude, :longitude, :zipcode

end