class Poll < ActiveRecord::Base
  has_many :staff_polls
  has_many :option

  def get_list_staff_voted
    list_staff = Array.new
    list_staff_poll = StaffPoll.where(:poll_id => self.id)
    puts "#{list_staff_poll.size}"
    list_staff_poll.each do |staff_poll|
      staff_id = staff_poll.staff_id
      list_staff.push(Staff.find(staff_id))
    end
    return list_staff
  end

  def get_list_option_id
    list_id = Array.new()
    self.option.each do |option|
      list_id.push(option.id)
    end
    return list_id
  end


end
