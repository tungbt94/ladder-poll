class PollsController < ApplicationController
  def index
  	@polls = Poll.paginate(page: params[:page])
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.option
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.create!(
      id: Poll.last.id + 1,
      content: params.require(:poll).permit(:content).to_s,
      staff_id: session[:user_id],
      created_at: "",
      updated_at: ""
    )
    redirect_to(@poll)
  end

  def update
    # binding.pry
    @poll = Poll.find(params[:id])
    if  params[:poll]
      checked_options = params[:poll][:options].values
      if params[:commit] == 'Vote'
        vote(poll, checked_options)
      elsif params[:commit] == 'Delete'

      end
      redirect_to(@poll)
    end
  end

  def vote(poll, checked_options)
    checked_options.each do |option_id|
      if StaffPoll.exist(session[:user_id], option_id)
        StaffPoll.create(session[:user_id], poll.id, option_id)
      end
    end
    unchecked_options = poll.get_list_option_id - checked_options
    unchecked_options.each do |option_id|
      if StaffPoll.exist(session[:user_id], option_id)
        StaffPoll.destroy(session[:user_id], poll.id, option_id)
      end
    end
  end

end
