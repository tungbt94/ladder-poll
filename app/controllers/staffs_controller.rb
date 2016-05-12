class StaffsController < ApplicationController
  LISTDOMAIN = ["vccloud.vn", "vcc.vn", "admicro.vn"]
  def edit
  	@staff = Staff.find(session[:user_id])
  end

  def show
    @staff = Staff.find(session[:user_id])
  end

  def update
    @staff = Staff.find(session[:user_id])
    if verify
      if @staff.update_attributes(staff_params)
        # Handle a successful update.
          @staff.update_attributes(actived: true)
          flash[:success] = "Profile updated"
          redirect_to staffs_edit_path
      else
       redirect_to staffs_edit_path
      end
    else
      flash[:success] = "Not verify infomation"
      redirect_to staffs_edit_path
    end

  end

  def verify
    # verify email
    email = staff_params.to_h["email"].to_s
    domain = email.partition('@').last
    if LISTDOMAIN.include?(domain)
      return true
    else
      return false
    end
  end

  private
   def staff_params
      params.require(:staff).permit(:name, :email, :department,
                                   :division)
   end
end
