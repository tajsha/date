class Message < ActiveRecord::Base
	attr_accessible :subject, :body, :sender_id, :recipient_id, :read_at,:sender_deleted,:recipient_deleted
	validates_presence_of :subject, :message => "Please enter message title"

	belongs_to :sender,
	:class_name => 'User',
	:foreign_key => 'sender_id'
	belongs_to :recipient,
	:class_name => 'User',
	:foreign_key => 'recipient_id'
	belongs_to :user
	has_many :notifications, as: :event
	
	after_create :send_notification

    # marks a message as deleted by either the sender or the recipient, which ever the user that was passed is.
    # When both sender and recipient marks it deleted, it is destroyed.
    def mark_message_deleted(id,user_id)
         self.sender_deleted = true if self.sender_id == user_id
         self.recipient_deleted = true if self.recipient_id == user_id
         (self.sender_deleted && self.recipient_deleted) ? self.destroy : self.save!
     end
    # Read message and if it is read by recipient then mark it is read
    def readingmessage
      self.read_at ||= Time.now
      save
    end
    
    # Based on if a message has been read by it's recipient returns true or false.
    def read?
    	self.read_at.nil? ? false : true
    end

    def self.received_by(user)
       where(:recipient_id => user.id)
     end

     def self.not_recipient_deleted
       where("recipient_deleted = ?", false)
     end
     
     def self.sent_by(user)
        Message.where(:sender_id => user.id)
      end
      
      def previous(same_recipient = true)
        collection = Message.where('id <> ? AND created_at > ?', self.id, self.created_at).order('created_at ASC')
        collection.where(recipient_id: self.recipient_id) if same_recipient
        collection.first
      end

      def next(same_recipient = true)
        collection = Message.where('id <> ? AND created_at < ?', self.id, self.created_at).order('created_at DESC')
        collection.where(recipient_id: self.recipient_id) if same_recipient
        collection.first
      end
      
      private
      
      def send_notification(message)
        message.notifications.create(user: recipient_id)
      end
    end