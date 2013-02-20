class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :about_me, :password, :birthday, :career, :children, :education, :email, :ethnicity, :gender, :height, :name, :password_digest, :politics, :religion, :sexuality, :user_drink, :user_smoke, :username, :zip_code
  
  validates_uniqueness_of :email

end
