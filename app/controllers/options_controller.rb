class OptionsController < ApplicationController
  def index
    @option = @poll.get_list_option
  end

  def new
    @option = Option.new
  end

  def create
    binding.pry
    poll_id = params[:option][:poll_id]
    @option = Option.create!(
      id: Option.last.id + 1,
      content: params[:option][:content],
      poll_id: poll_id,
      created_at: "",
      updated_at: ""
    )
    @poll = Poll.find_by_id(poll_id)
    redirect_to(@poll)
  end

  def edit
  end

  def delete
  end

end
