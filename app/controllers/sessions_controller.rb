class SessionsController < ApplicationController
  def create
  	staff = Staff.from_omniauth(env["omniauth.auth"])
    session[:user_id] = staff.id
    if staff.actived == false
    	redirect_to staffs_edit_path
    else
    	redirect_to static_pages_home_path
    end
  end

  def destroy
	session[:user_id] = nil
    redirect_to root_path
  end
end
