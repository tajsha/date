class AnswersController < ApplicationController
  
  def new
    @question = Question.find(params[:question_id])
  end
  
  def create
    @question = Question.find(params[:question_id])
    if @question.update_attributes(params[:question])
      redirect_to questions_path
    else
      render :new
    end
  end
end
