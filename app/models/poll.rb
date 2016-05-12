class Poll < ActiveRecord::Base
  has_many :staff_polls
  has_many :option

  def get_list_staff_voted
  end

end
