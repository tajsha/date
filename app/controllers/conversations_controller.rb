class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation
  
  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all
    
    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation
      
      redirect_to conversation
    end
    
    def reply
      current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
      redirect_to conversation
    end
    
    def trash
      conversation.move_to_trash(current_user)
      redirect_to :conversations
    end
    
    def untrash
      confersation.untrash(current_user)
      redirect_to :conversations
    end
    
    private
    
    def mailbox
      @mailbox ||