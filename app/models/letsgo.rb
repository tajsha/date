class Letsgo < ActiveRecord::Base
  attr_accessible :message, :content, :tag
  belongs_to :user
  belongs_to :message
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 360 }
  validates :user_id, presence: true
  scope :random, -> { order("RANDOM()") }
  
  def repost(user_object)
    new_letsgo = self.dup #duplicates the entire object, except for the ID
    new_letsgo.user_id = user_object.id
    new_letsgo.repost_from_user_id = self.id #save the user id of original repost, to keep track of where it originally came from
    new_letsgo.save
end

def is_repost?
  repost_from_user_id.present?
end

def original_user
  User.find(repost_from_user_id) if is_repost?
end
end