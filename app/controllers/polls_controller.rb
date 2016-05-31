class PollsController < ApplicationController
  def index
  	@polls = Poll.paginate(page: params[:page])
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.get_list_option
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.create!(
      id: Poll.last.id + 1,
      content: params[:content],
      staff_id: session[:user_id],
      created_at: "",
      updated_at: ""
    )
  end

  def update
  end


end
