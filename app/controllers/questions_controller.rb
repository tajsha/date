class QuestionsController < ApplicationController
  respond_to :js, :html


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
      @conversation = Conversation.new
      if @question.save
        #scoping to the current user is the right thing to do here
        @message = current_user.messages.new(:subject => "You have a question from #{@question.sender_id}",
                               #Original code :sender_id
                               :notification_id => @question.sender_id,
                               #Original code :recipient_id
                               :receiver_id => @question.recipient_id,
                               :conversation_id => @conversation.id,
                               :body => @question.question)

        @question.message = @message
        @question.save
        redirect_to :back, notice: 'Your question was saved successfully. Thanks!'
      else
        render :new, alert: 'Sorry. There was a problem saving your question.'
      end
    end
  end