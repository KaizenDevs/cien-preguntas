class AnswersController < ApplicationController
  before_action :token_authentication, only: [:new]
  before_action :authenticate_user!, except: [:show]
  before_filter :has_answer?, :only => [:new,:create]
  respond_to :html, :json
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
    @question_id = @answer.question.id
    @answer_owner_id =  @answer.user.id
    if user_signed_in?
      raise ActionController::RoutingError.new('Not Found') if  @answer_owner_id  != current_user.id && @answer.public_answer == false
    else
      raise ActionController::RoutingError.new('Not Found')  if @answer.public_answer == false
    end



    @answers = Answer.where(question_id: @answer.question.id, public_answer: true).where.not(user_id:@answer.user_id).shuffle
    # Filter if the user is loged in or not
    # if user_signed_in?
    #   if @answer.public_answer
    #     # If the user is loged in and the answer is public show the answer
    #     @answer = Answer.find(params[:id])
    #     if current_user.questions.include?(Question.find(params[:question_id]))
    #       # # If the user is loged in, the answer is public and the user has and answer as public for this question call all the public answers for the same question unless the answer from the user_id from @answer
    #       @answers = Answer.where(question_id: @answer.question.id, public_answer: true).where.not(user_id:@answer.user_id).shuffle
    #     end
    #   elsif @answer.public_answer == false
    #     # If the user is private don't show answer and redirect to
    #     redirect_to root_path, :alert => "Lo sentimos, no puedes acceder al contenido de una respuesta privada"
    #   end
    # else
    #   if @answer.public_answer
    #     # If the user is not loged in and the answer is public show just this answer
    #     @answer = Answer.find(params[:id])
    #   elsif @answer.public_answer == false
    #     redirect_to root_path, :alert => "Lo sentimos, no puedes acceder al contenido de una respuesta privada"
    #   end
    # end
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = params[:question_id]
    if @answer.save
      streak = PagesHelper.day_streak(current_user).count
      current_user.update(max_streak: streak) if current_user.max_streak < streak
      redirect_to @answer
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
    # redirect_to pages_profile_path
    # render json: @answer
    render json: @answer, status: 201
  end

  private
  def answer_params
    params.require(:answer).permit(:answer, :public_answer)
  end

  def has_answer?
    if current_user.questions.include?(Question.find(params[:question_id]))
      redirect_to root_path, :alert => "Lo sentimos, usted ya ha respondido esta pregunta, dirijase a su página de perfil si desea editar la respuesta"
    end
  end

  def token_authentication
    if params[:token]
      user = User.find_by(auth_token: params[:token])
      if user == nil
        redirect_to root_path
      else
        sign_in user
      end
    end
  end
end
