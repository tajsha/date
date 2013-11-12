class Conversation < ActiveRecord::Base
  has_many :messages
  
    def most_recent_message_body
      most_recent_message.body if most_recent_message
    end

    def most_recent_message_sent_at
      most_recent_message.created_at if most_recent_message
    end

    def reply_count
      messages.size - 1
    end

    def recipient_id
      recipient.id
    end

    def sender_id
      sender.id
    end

    private
    def most_recent_message
      @most_recent_message ||= messages.by_date.first
    end
  end