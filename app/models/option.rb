class Option < ActiveRecord::Base
  belongs_to :poll

  def get_list_staff_voted
    list_staff_poll = StaffPoll.where(:option_id => self.id)
    list_staff = Array.new
    @sum_score = 0
    staff = Staff.new
    list_staff_poll.each do |staff_poll|
      staff_id = staff_poll.staff_id
      staff = Staff.find(staff_id)
      list_staff.push(staff)
      @sum_score += staff.get_score
    end
    return list_staff
  end

  def get_sum_score
    # self.get_list_staff_voted
    return @sum_score
  end

  def get_poll
    return Poll.find(self.poll_id)
  end
end
