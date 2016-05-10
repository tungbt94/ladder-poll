class SessionsController < ApplicationController
  def create
  	staff = Staff.from_omniauth(env["omniauth.auth"])
    session[:user_id] = staff.id
    if staff.actived == false
    	redirect_to edit_path
    else
    	redirect_to home_path
    end
  end

  def destroy
	session[:user_id] = nil
    redirect_to root_path
  end
end
