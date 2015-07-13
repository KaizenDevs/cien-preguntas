class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  before_action :admin_only, only: [:metrics]

	def home
	end

  def profile
    @user = current_user
  end

  def metrics
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Acceso denegado, no posee permisos como administrador"
    end
  end
end
