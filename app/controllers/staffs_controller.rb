class StaffsController < ApplicationController
  LISTDOMAIN = ["vccloud.vn", "vcc.vn", "admicro.vn"]
  def edit
  	@staff = Staff.find(session[:user_id])
  end

  def show
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(session[:user_id])
    if manager_email_exist
      if @staff.update_attributes(staff_params)
        # Handle a successful update.
          @staff.update_attributes(actived: true)
          flash[:success] = "Profile updated"
      else
        flash[:alert] = "manager email not exist"
      end
    else
      flash[:error] = "Not verify infomation"
    end
    redirect_to staff_edit_path
  end

  def manager_email_exist
    manager_email = params.require(:staff).permit(:manager_id).to_s.downcase!
    if manager_email && Staff.where(:email => manager_email)
        return true
    else
      return false
    end
  end

  # verify email
  def verify_email
    email = params.require(:staff).permit(:email).to_s.downcase!
    if email
      domain = email.split('@').last
      if LISTDOMAIN.include?(domain)
        return true
      end
      flash[:error] = "domain is not exist"
    else
      flash[:error] = "email is nil"
      return true
    end
  end

  private
   def staff_params
      manager_email = params.require(:staff).permit(:manager_id).to_s.downcase!
      manager_id = Staff.get_id_by_email(manager_email)
      params[:staff][:manager_id] = manager_id
      params.require(:staff).permit(:name, :email, :manager_id, :department,
                                   :division)
      # params.require(:staff).permit(:name, :email, :department,:division)
   end
end
