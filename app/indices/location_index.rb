ThinkingSphinx::Index.define :location, :with => :active_record do
  # fields
  has "RADIANS(latitude)",  :as => :latitude,  :type => :float
  has "RADIANS(longitude)", :as => :longitude, :type => :float

# attributes
end