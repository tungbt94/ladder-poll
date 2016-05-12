class PollsController < ApplicationController
  def show
  	@list_poll = Poll.all
  end

  def new
  end

  def update
  end
end
