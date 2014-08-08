class Question < ActiveRecord::Base
    acts_as_messageable
    
  attr_accessible :answer, :question, :sender_id, :recipient_id, :conversation_id
  belongs_to :user

  belongs_to :sender,:class_name => 'User',:foreign_key => 'sender_id'

  belongs_to :recipient,:class_name => 'User',:foreign_key => 'recipient_id'

  belongs_to :message
  
  belongs_to :conversation
  
  

    
      def mailboxer_email(object)
          if self.no_email
            email
          else
              nil
          end
  end
  end