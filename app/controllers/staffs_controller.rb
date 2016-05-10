class StaffsController < ApplicationController
  def edit
  	@staff = Staff.find(session[:user_id])
  end

  def show
  end

  def update
    @staff = Staff.find(session[:user_id])
    if @staff.update_attributes(staff_params)
    # Handle a successful update.
      @staff.update_attributes(actived: true)
      flash[:success] = "Profile updated"
      redirect_to staffs_show_path
    else
     render 'edit'
    end

  end

   def staff_params
      params.require(:staff).permit(:name, :email, :department,
                                   :division)
   end
end
