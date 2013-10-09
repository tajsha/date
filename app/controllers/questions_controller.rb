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
  @question = Question.new(params[:question])
  if @question.save
    @message = Message.create(:subject => "You have a question from #{@question.sender_id}",
                           :sender_id => @question.sender_id,
                           :recipient_id => @question.recipient_id,
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