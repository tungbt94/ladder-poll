class Option < ActiveRecord::Base
  belongs_to :poll

  def get_list_staff_voted
  end

  def get_sum_score
  end
end
