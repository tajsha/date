class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages
    elsif params[:mailbox] == "inbox"
      @messages = @user.received_messages
    #elsif params[:mailbox] == "archived"
     # @messages = @user.archived_messages
    end
    if params[:mailbox] == "unread"
    @messages = @user.unread_messages
  end
  end
  
  def new
    @message = Message.new
    if params[:reply_to]
      @reply_to = User.find_by_user_id(params[:reply_to])
      unless @reply_to.nil?
        @message.recipient_id = @reply_to.user.id
      end
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender_id = @user.id
    if @message.save
      flash[:notice] = "Message has been sent"
      redirect_to user_messages_path(current_user, :mailbox=>:inbox)
    else
      render :action => :new
    end
  end

  def show
     @message = Message.find(params[:id])
     @message.readingmessage if @message.recipient == current_user
 end
 
 def perform(message_id, user_id)
    message = Message.find(message_id)
    user = Message.find(user_id)
    message.read_at = Time.now
    old_msg_count = user.messages.count

    if message.save
      msg_response_time = message.read_at - message.created_at

      response_rate = (user.messages.where("read_at IS NOT NULL").count)/(old_msg_count + 1)
      response_time = ((user.average_response_time * old_msg_count)+msg_response_time)/(old_msg_count + 1)
      user.update_attributes(:response_rate => response_rate, :average_response_time => average_response_time )
    end
  end

 
   def destroy
     @message = Message.find(params[:id])
     @message.destroy
     flash[:notice] = "Successfully deleted message."
     redirect_to user_messages_path(@user, @messages)
   end
  
  def delete_multiple
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(id)
          @message.mark_message_deleted(@message.id,@user.id) unless @message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to user_messages_path(@user, @messages)
  end
  
  private
    def set_user
      @user = current_user
  end
end