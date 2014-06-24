class Conversation < ActiveRecord::Base
  acts_as_messageable
  
  attr_accessible :answer, :question, :sender_id, :recipient_id, :conversation_id
  
  has_many :questions

end