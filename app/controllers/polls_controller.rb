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
    binding.pry
    @poll = Poll.create!(
      id: Poll.last.id + 1,
      content: params[:poll][:content],
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
      checked_options = checked_options.map(&:to_i)
      if params[:commit] == 'Vote'
        vote(@poll, checked_options)
      elsif params[:commit] == 'Delete'
        delete(@poll,checked_options)
      end
      redirect_to(@poll)
    else
      flash[:warning] = "0 option is selected"
      redirect_to(@poll)
    end
  end

  def vote(poll, checked_options)
    checked_options.each do |option_id|
      unless StaffPoll.exist(session[:user_id], option_id)
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

  def delete(poll, checked_options)
    checked_options.each do |option_id|
      Option.destroy(option_id)
      StaffPoll.destroy(option_id)
    end
  end

  def destroy(poll_id)
    Poll.destroy(poll_id)
    Option.destroy(poll_id)
    StaffPoll.destroy(poll_id)
  end
end
