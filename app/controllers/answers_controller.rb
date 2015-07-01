class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id]).question
  end

  def edit
  end

  def show
  end

  def index
  end
end
