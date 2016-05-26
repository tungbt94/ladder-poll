module PollsHelper
  def have_polls?
    Poll.all.size > 0
  end
end
