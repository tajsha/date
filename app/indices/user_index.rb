ThinkingSphinx::Index.define :location, :with => :active_record do 
  indexes city 
  
  has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(locations.longitude)", :as => :longitude, :type => :float
end 

ThinkingSphinx::Index.define :user, :with => :active_record do 
  indexes name, :as => :user, :sortable => true 
  indexes zip_code

  has created_at, updated_at 
  has location.id, :as => :location_id
end 
