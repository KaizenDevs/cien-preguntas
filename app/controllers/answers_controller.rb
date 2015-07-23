class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_filter :has_answer?, :only => [:new,:create]

  def index
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end


  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def show
    @answer = Answer.find(params[:id])
    if @answer.public_answer
      # Call all the public answers for the same question unless the answer from the user_id from @answer
      @answers = Answer.where(question_id: @answer.question.id, public_answer: true).where.not(user_id:@answer.user_id).shuffle      
    end
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

  def update
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    if @answer.update(answer_params)
      flash[:notice] = "La respuesta ha sido actualizada exitosamente!"
      redirect_to pages_profile_path
    else
      flash[:alert] = "La respuesta no ha sido, actualizada. La respuesta no puede estar vacía"
      render 'edit'
    end
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

    def has_answer?
      if Answer.where(user_id: current_user.id,question_id: @question_id)
        redirect_to root_path, :alert => "Lo sentimos, usted ya ha respondido esta pregunta, dirijase a su página de perfil si desea editar la respuesta"
      end
    end
end
