class PagesController < ApplicationController
  before_action :token_authentication, only: [:profile]
  before_action :authenticate_user!, only: [:profile]
  before_action :admin_only, only: [:metrics]
  respond_to :html, :json
  include ApplicationHelper

	def home
     render :layout => 'application_home'
	end

  def profile
    if params.has_key?(:user_id)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def streak_tooltip
    user = User.find(params[:user])
    streak_array = PagesHelper.day_streak(user)
    streak_array.map { |a|
      a[:question] = a[:answer].first.question.question
      a[:question_id] = a[:answer].first.question.id
      a[:public_answer] = a[:answer].first.public_answer
      a[:answer] = a[:answer].first.id
    }
    render json: streak_array.to_json, status: 201
  end

  def metrics
    @answers = Answer.all
    @users = User.where(role: 0)
  end

  def daily_concepts
    daily_array = []
    ((Date.today - 1.month)..Date.today).map do |date|
      daily_array.push({
        day: date.strftime(),
        answer: Answer.where(created_at: date.beginning_of_day..date.end_of_day).count,
      })
    end
    render json: daily_array.to_json, status: 201
  end

  def public_private_switch
    answer = Answer.find(params[:answer_id])
    if answer.public_answer == true
      answer.update(public_answer: false)
      response = {response: "updated to false"}
    else
      answer.update(public_answer: true)
      response = {response: "updated to true"}
    end
    render json: response, status: 201
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Acceso denegado, no posee permisos como administrador"
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
