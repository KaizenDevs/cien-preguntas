class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new()
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def import
    Question.import(params[:file])
    redirect_to questions_path, notice: "Se han importado las preguntas."
  end

  private
  def question_params
    params.require(:question).permit(:question)
  end

end