class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = params[:question_id]
    if @answer.save
      redirect_to [@question, @answer]
    else
      flash[:alert] = "La respuesta no puede estar vacía."
      render 'new'
    end
  end

  def edit
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def index
  end

  private
    def answer_params
      params.require(:answer).permit(:answer, :public_answer)
    end
end
