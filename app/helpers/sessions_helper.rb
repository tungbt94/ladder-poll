module SessionsHelper
  	def current_user
    	@current_user ||= Staff.find(session[:user_id]) if session[:user_id]
	end
end
