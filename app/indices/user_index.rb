ThinkingSphinx::Index.define :location, :with => :active_record do 
  indexes city 
  
  has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(locations.longitude)", :as => :longitude, :type => :float
end 

ThinkingSphinx::Index.define :user, :with => :active_record do 
  indexes name, :as => :user, :sortable => true 
  indexes religion, about_me, height, career, feet, inches, sexuality, children, user_smoke, user_drink, politics, gender, ethnicity, education
  has created_at, updated_at 
  has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(locations.longitude)", :as => :longitude, :type => :float
  has(:id, :as => :user_id)
  has(:zip_code, :as => :zip_code, :type => :integer)
  has age
  has username
  has birthday
  has email
  has zip_code
  set_property :wordforms => 'lib/word.txt'
  join location
end 
