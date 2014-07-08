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
    @conversation = Conversation.create
    @question = Question.new(params[:question])
      if @question.save
        @message = current_user.messages.new(:subject => "You have a question from #{@question.sender_id}",
                               :body => @question.question)
        @question.message = @message
        @question.save
        redirect_to :back, notice: 'Your question was saved successfully. Thanks!'
      else
        render :new, alert: 'Sorry. There was a problem saving your question.'
      end
    end
  end