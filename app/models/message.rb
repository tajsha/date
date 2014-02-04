class Message < ActiveRecord::Base
	attr_accessible :subject, :conversation_id, :body, :parent_id, :sender_id, :recipient_id, :read_at,:sender_deleted,:recipient_deleted
	validates_presence_of :subject, :message => "Please enter message title"
	has_many :notifications, as: :event
	belongs_to :conversation, inverse_of: :messages
	belongs_to :user
  scope :unread, -> {where('read_at IS NULL')}
  scope :not_deleted_by_recipient, where('messages.recipient_deleted IS NULL OR messages.recipient_deleted = ?', false)
  scope :not_deleted_by_sender, where('messages.sender_deleted IS NULL OR messages.sender_deleted = ?', false)

	belongs_to :sender,
	:class_name => 'User',
	:foreign_key => 'sender_id'
	belongs_to :recipient,
	:class_name => 'User',
	:foreign_key => 'recipient_id'
	
	has_one :question
	has_one :letsgo
	

	def reply
	  new_message.reply_from_user_id = self.id #save the user id of original repost, to keep track of where it originally came from
  end

  def self.by_date
      order("created_at DESC")
    end
    
    # marks a message as deleted by either the sender or the recipient, which ever the user that was passed is.
    # When both sender and recipient marks it deleted, it is destroyed.
    def mark_message_deleted(id,user_id)
            self.sender_deleted = true if self.sender_id == user_id
            self.recipient_deleted = user_id if self.recipient_id == user_id
            (self.sender_deleted > 0 && self.recipient_deleted > 0) ? self.destroy : self.save!
            (self.sender_deleted != 0 && self.recipient_deleted != 0)
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
      
      def next(same_recipient = true)
        collection = Message.where('id <> ? AND created_at > ?', self.id, self.created_at).order('created_at ASC')
        collection.where(recipient_id: self.recipient_id) if same_recipient
        collection.first
      end

      def previous(same_recipient = true)
        collection = Message.where('id <> ? AND created_at < ?', self.id, self.created_at).order('created_at DESC')
        collection.where(recipient_id: self.recipient_id) if same_recipient
        collection.first
      end
    end
      
    private
    def send_notification(message)
      message.notifications.create(user: message.recipient)
    end
  