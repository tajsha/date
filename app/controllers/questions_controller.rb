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
    redirect_to questions_path, notice: 'Your question was saved successfully. Thanks!'
  else
    render :new, alert: 'Sorry. There was a problem saving your question.'
  end
end
end
