class Gallery < ActiveRecord::Base
   attr_accessible :title, :body, :name
   has_many :photos
end
