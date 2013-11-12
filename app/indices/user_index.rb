ThinkingSphinx::Index.define :user, :with => :active_record do
  # fields
  indexes name, :as => :user, :sortable => true
  indexes religion, zip_code, about_me, career, sexuality, children, user_smoke, user_drink, age, gender, ethnicity, education, username
# attributes
  has created_at, updated_at
  
  indexes city, :as => :city_name
  indexes state, :as => :state_name

      has "RADIANS(locations.latitude)",  :as => :latitude,  :type => :float
      has "RADIANS(locations.longitude)", :as => :longitude, :type => :float

      set_property :latitude_attr => :latitude, :longitude_attr => :longitude
end