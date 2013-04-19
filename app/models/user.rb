# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  zip_code               :string(255)
#  birthday               :string(255)
#  name                   :string(255)
#  username               :string(255)
#  gender                 :string(255)
#  ethnicity              :string(255)
#  sexuality              :string(255)
#  career                 :string(255)
#  education              :string(255)
#  religion               :string(255)
#  politics               :string(255)
#  children               :string(255)
#  height                 :string(255)
#  user_smoke             :string(255)
#  user_drink             :string(255)
#  about_me               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :role, :age, :age_end, :password_confirmation, :about_me, :feet, :inches, :password, :birthday, :career, :children, :education, :email, :ethnicity, :gender, :height, :name, :password_digest, :politics, :religion, :sexuality, :user_drink, :user_smoke, :username, :zip_code
  validates_uniqueness_of :email
  validates_format_of :email, with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  has_many :galleries
  has_many :photos, :through => :galleries
  before_create { generate_token(:auth_token) }
  ROLES = %w[admin user guest banned]
  
  # models/user.rb
  after_create :setup_gallery
  
  def received_messages
      Message.received_by(self)
    end
 
 def unread_messages?
   unread_message_count > 0 ? true : false
 end
 
 def sent_messages
   Message.sent_by(self)
 end
 
 # Returns the number of unread messages for this user
 def unread_message_count
   eval 'messages.count(:conditions => ["recipient_id = ? AND read_at IS NULL", self.user_id])'
 end
 
  def to_s; username
  end
  
  def has_role?(role_name)
    role.present? && role.to_sym == role_name.to_sym
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private
  def setup_gallery
     self.galleries << Gallery.create
   end
end