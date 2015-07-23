class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
  end

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
      streak = PagesHelper.day_streak(current_user).count
      current_user.update(max_streak: streak) if current_user.max_streak < streak
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

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to pages_profile_path
  end

  private
    def answer_params
      params.require(:answer).permit(:answer, :public_answer)
    end
end
