class UsersController < ApplicationController
	before_filter :authenticate_user!
	include ApplicationHelper

	def edit 
		@user = current_user
		if facebook_user?
			@temp = true
			render "edit_facebook_user"
		else
			render "edit"
		end
	end
end
