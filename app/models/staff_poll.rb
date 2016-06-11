class StaffPoll < ActiveRecord::Base
  belongs_to :staff
  belongs_to :poll
  belongs_to :option

  def self.exist(staff_id, option_id)
    return true if StaffPoll.where(:staff_id => staff_id, :option_id => option_id).first
    return false
  end

  def self.create(staff_id, poll_id, option_id)
    StaffPoll.create!(
      staff_id: staff_id,
      poll_id: poll_id,
      option_id: option_id
    )
  end

  def self.destroy(staff_id, poll_id, option_id)
    StaffPoll.where(
      :staff_id => staff_id,
      :poll_id => poll_id,
      :option_id => option_id).destroy
  end

  def self.destroy(option_id)
    staff_polls = StaffPoll.where(:option_id => option_id)
    binding.pry
    if staff_polls.size > 0
      staff_polls.destroy
    end
  end
end
