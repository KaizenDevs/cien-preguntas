class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  before_action :admin_only, only: [:metrics]
  respond_to :html, :json

	def home
	end

  def profile
    @user = current_user
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
        answer: Answer.where(created_at: date.beginning_of_day..date.end_of_day).count
      })
    end
    render json: daily_array.to_json, status: 201
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Acceso denegado, no posee permisos como administrador"
    end
  end
end
