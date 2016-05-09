module SessionsHelper
	 # Logs in the given staff.
	 def log_in(staff)
	   session[:user_id] = staff.id
	 end

	 # Returns the current logged-in staff (if any).
	 def current_staff
	   @current_staff ||= Staff.find(session[:user_id]) if session[:user_id]
	 end

	 # Returns true if the user is logged in, false otherwise.
	 def logged_in?
	   !current_staff.nil?
	 end
end
