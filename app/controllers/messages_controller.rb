class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    elsif params[:mailbox] == "inbox"
      @messages = @user.received_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    #elsif params[:mailbox] == "archived"
     # @messages = @user.archived_messages
    end
    if params[:mailbox] == "unread"
    @messages = @user.unread_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end
  if params[:mailbox] == "trash"
    @messages = @user.deleted_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end
  end
  
  def new
    @message = Message.new
    if params[:reply_to]
      @reply_to = User.find_by_id(params[:reply_to])
      unless @reply_to.nil?
        @message.recipient_id = @reply_to.id
      end
    end
  end
  
  def askout
    @message = Message.new
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
  
  def reply
    @message = Message.find(params[:id]).reply(id)
  end
  
  
  def update
      @message = Message.new
      if params[:reply_to]
        @reply_to = User.find_by_id(params[:reply_to])
        unless @reply_to.nil?
          @message.recipient_id = @reply_to.id
        end
      end
    end
  
  private
    def set_user
      @user = current_user
  end
end