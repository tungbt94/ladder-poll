class PollsController < ApplicationController
  def index
  	@polls = Poll.paginate(page: params[:page])
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.get_list_option 
  end

  def new
  end

  def update
  end
end
