class Question < ActiveRecord::Base
<<<<<<< HEAD
    acts_as_messageable
    
  attr_accessible :answer, :question, :sender_id, :recipient_id, :conversation_id
=======
  attr_accessible :answer, :question, :sender_id, :recipient_id
>>>>>>> FETCH_HEAD
  belongs_to :user
  
  belongs_to :sender,
	:class_name => 'User',
	:foreign_key => 'sender_id'
	belongs_to :recipient,
	:class_name => 'User',
	:foreign_key => 'recipient_id'
	
	belongs_to :message
	
end
