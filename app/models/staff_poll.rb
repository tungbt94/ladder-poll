class StaffPoll < ActiveRecord::Base
  belongs_to :staff
  belongs_to :poll
  belongs_to :option
end
