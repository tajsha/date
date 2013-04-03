class Message < ActiveRecord::Base
	attr_accessible :subject, :body, :sender_id, :recepient_id, :read_at,:sender_deleted,:recepient_deleted
	validates_presence_of :subject, :message => "Please enter message title"

	belongs_to :sender,
	:class_name => 'User',
	:foreign_key => 'sender_id'
	belongs_to :recepient,
	:class_name => 'User',
	:foreign_key => 'recepient_id'

    # marks a message as deleted by either the sender or the recepient, which ever the user that was passed is.
    # When both sender and recepient marks it deleted, it is destroyed.
    def mark_message_deleted(id,user_id)
    	self.sender_deleted = true if self.sender_id == user_id and self.id=id
    	self.recepient_deleted = true if self.recepient_id == user_id and self.id=id
    	self.sender_deleted && self.recepient_deleted ? self.destroy : save!
    end

    # Read message and if it is read by recepient then mark it is read
    def readingmessage
      read_at ||= Time.now
      save
    end
    
    # Based on if a message has been read by it's recepient returns true or false.
    def read?
    	self.read_at.nil? ? false : true
    end

    def self.received_by(user)
       where(:recepient_id => user.id)
     end

     def self.not_recepient_deleted
       where("recepient_deleted = ?", false)
     end

end