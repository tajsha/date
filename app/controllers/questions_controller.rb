class QuestionsController < ApplicationController
  respond_to :js, :html
  
  def index
    @questions = Question.all
    respond_with(@questions)
end

def show
  @question = Question.find(params[:id])
  @questions = Question.order("created_at DESC")
  respond_with(@questions)
end

def new
  @question = Question.new
  respond_with(@question)
end

def create
  @conversation = Conversation.new
  
    @question = @conversation.questions.build(params[:question])
    if @question.save
      #scoping to the current user is the right thing to do here
      @message = current_user.messages.new(:subject => "You have a question from #{@question.sender_id}",
                             #Original code :sender_id
                             :notification_id => @question.sender_id,
                             #Original code :recipient_id
                             :receiver_id => @question.recipient_id,
                             :body => @question.question)

      @question.message = @message
      @question.save
      redirect_to questions_path, notice: 'Your question was saved successfully. Thanks!'
    else
      render :new, alert: 'Sorry. There was a problem saving your question.'
    end
  end


  def update
    @question = Question.find(params[:id])
    @question.update_attributes(:answer => params[:question][:answer])
    redirect_to user_messages_path(current_user, :mailbox => "inbox")
end
end