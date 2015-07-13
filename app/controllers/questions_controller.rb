class QuestionsController < ApplicationController
  before_action :admin_only

  def index
    @questions = Question.all.sort
  end

  def new
    @question = Question.new()
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    if Question.last.nil?
      @question.id = 1
    else
      @question.id = Question.last.id + 1
    end

    if @question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path, notice: "Se ha editado la pregunta con éxito."
    else
      render 'edit', alert: "Hubo un error y no se pudo editar la pregunta."
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def import
    Question.import(params[:file])
    if params.has_key?(:file)
      redirect_to questions_path, notice: "Se han importado las preguntas."
    else
      redirect_to questions_path, alert: "Debe agregar un archivo primero."
    end
  end

  private
  def question_params
    params.require(:question).permit(:question, :id)
  end

  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Acceso denegado, no posee permisos como administrador"
    end
  end

end