module ApplicationHelper
	def facebook_user?
    current_user.provider == 'facebook' ? true : false
  end
end
