class PollsController < ApplicationController
  def index
  	@polls = Poll.paginate(page: params[:page])
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def new
  end

  def update
  end
end
