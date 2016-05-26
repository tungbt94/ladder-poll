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
    if verify_email && manager_email_exist
    # if manager_email_exist
      if @staff.update_attributes(staff_params)
        # Handle a successful update.
          @staff.update_attributes(actived: true)
          flash[:success] = "Profile updated"
          redirect_to staff_edit_path
      else
        flash[:alert] = "Profile not updated"
       redirect_to staff_edit_path
      end
    else
      flash[:error] = "Not verify infomation"
      redirect_to staff_edit_path
    end
  end

  def manager_email_exist
    manager_email = params.require(:staff).permit(:manager_id).to_s.downcase!
    if manager_email
      if Staff.where(:email => manager_email)
        return true
      end
      flash[:alert] = "manager email not exist"
      return false
    else
      return false
    end
  end

  def verify_email
    # verify email
    email = params.require(:staff).permit(:email).to_s.downcase!
    # flash[:motice] = "email: #{email}"
    if email
      domain = email.split('@').last
      if LISTDOMAIN.include?(domain)
        return true
      else
        flash[:alert] = "email not verify"
        return false
      end
    else
      return true
    end
  end

  private
   def staff_params
      manager_id = params.require(:staff).permit(:manager_id).to_s.downcase!
      params[:staff][:manager_id] = manager_id
      flash[:alert] = "manager_id:#{manager_id}"
      params.require(:staff).permit(:name, :email, :manager_id, :department,
                                   :division)
      # params.require(:staff).permit(:name, :email, :department,:division)
   end
end
