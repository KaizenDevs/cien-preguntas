class UserController < ApplicationController
	before_action :token_authentication, only: [:edit]
	before_action :authenticate_user!
	include ApplicationHelper

	def index
		@users = User.where(role: 0)
	end

	def edit
		@user = current_user
		render "edit"
	end

	def update
	  @user = current_user
	  if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
	      params[:user].delete(:password)
	      params[:user].delete(:password_confirmation)
	  end
	  if @user.update(user_params)
	    flash[:notice] = "El usuario #{@user.email} fue actualizado con éxito"
	    sign_in @user, :bypass => true
	    redirect_to root_path(:id => @user.id)
	  else
	    flash[:alert] = "Ha ocurrido un error y el usuario #{@user.email}, no ha sido actualizado"
	    render :action => 'edit'
	  end
	end

	private
		def user_params
		  params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
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
