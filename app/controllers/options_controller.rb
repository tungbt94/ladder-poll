class OptionsController < ApplicationController
  def index
    @option = @poll.get_list_option
  end

  def new
  end

  def edit
  end

  def delete
  end

  def vote
    StaffPoll.create(
      staff_id: session[:user_id],
      option_id: option.id,
      poll_id: option.poll_id
    )
  end

  def unvote
    StaffPoll.where(
      :staff_id => session[:user_id],
      :option_id => option.id,
      :poll_id => option.poll_id
    ).first.destroy
  end
end
