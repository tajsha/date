class ConversationsController < ApplicationController
  helper_method :mailbox, :conversation
  before_filter :conversation, only: :show

  def index
    @user = current_user
    sentbox_page = params[:page] if params[:sentbox].present?
    inbox_page = params[:page] if params[:inbox].present?
    mailbox = @user.mailbox
    @inbox = mailbox.inbox.paginate(:page => inbox_page, :per_page => 5)
    @sentbox = mailbox.sentbox.paginate(:page => sentbox_page, :per_page => 5)
    render layout: 'new_application'
  end

  def show
    user = current_user
    @receipts = conversation.receipts_for(user).paginate(:page => params[:page], :per_page => 5)
    @conversation.receipts.recipient(user).update_all(is_read: true)
    respond_to do |format| 
      format.html {render layout: 'new_application'}
      format.js {}
    end
  end
  
  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end
    
  def trash_folder
    @trash ||= current_user.mailbox.trash.all 
  end
    
  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end
    
  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end
    
  def empty_trash
    current_user.mailbox.trash.each do |conversation|    
      conversation.receipts_for(current_user).update_all(:deleted => true)
    end
   redirect_to :conversations
  end
          
  private

  def mailbox
   @mailbox ||= current_user.mailbox
  end

  def conversation
   @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
   fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
   fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
   params[key].instance_eval do
     case subkeys.size
     when 0 then self
     when 1 then self[subkeys.first]
     else subkeys.map{|k| self[k] }
     end
   end
  end
end