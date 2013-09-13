class Zip < ActiveRecord::Base
  validates :code, uniqueness: true
  
    self.primary_key = 'code'
    has_many :users, foreign_key: 'zip_code'
  
    
  def self.code(code)
    find_by(:code => code)
  end
  
  # Returns a hash with values that can be used 
  # to perform a proximity search query
  def area_for(radius)
    area = {}
    area[:radius] = radius.to_f
    area[:lat_miles] = 69.172  #this is constant
    
    #longitude miles varies based on latitude, that is calculated here
    area[:lon_miles] = (area[:lat_miles] * Math.cos(lat * (Math::PI/180))).abs
 
    area[:lat_degrees] = radius/area[:lat_miles]  #radius in degrees latitude
    area[:lon_degrees] = radius/area[:lon_miles]  #radius in degrees longitude
 
    #now set min and max lat and long accordingly
    area[:min_lat] = lat - area[:lat_degrees]
    area[:max_lat] = lat + area[:lat_degrees]
    area[:min_lon] = lon - area[:lon_degrees]
    area[:max_lon] = lon + area[:lon_degrees]    
      
    area  
  end
  
end