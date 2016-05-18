class Staff < ActiveRecord::Base
  has_many :staff_poll
  before_save { if self.email.present?
  					self.email = email.downcase
  				end
				}
  validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@vccloud.vn/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, allow_nil: true

  # validates :validate_domain, on: :create

  def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize do |staff|
	    staff.provider = auth.provider
	    staff.uid = auth.uid
	    staff.name = auth.info.name
	    staff.oauth_token = auth.credentials.token
	    staff.save!
	  end
	end

	def set_active
		# self.update_attributes(actived: true)
    if(!self.actived)
      self.update_attributes(actived: true)
    else
      return false
    end
	end

  # get manager_level of staff
  def get_manager_level
    manager_level = 1
    staffs = Staff.where(:manager_id => self.id)
    if(staffs)
      manager_level = Staff.max_manager_level(staffs) + 1
    end
    return manager_level
  end

  # get score of staff
  def get_score
    sum_score = 0
    staffs = Staff.where(:manager_id => self.id)
    if(staffs)
      sum_score = Staff.get_sum_score(staffs)
    end
    @score = get_manager_level + self.key_person + Math.log(sum_score + 1, Math::E)
  end

  #get voted poll
  def get_voted_poll
    list_staff_poll = StaffPoll.where(:staff_id => self.id)
    list_voted_poll = Array.new
    list_staff_poll.each do |staff_poll|
      poll = Poll.find(staff_poll.poll_id)
      list_voted_poll.push(poll)
    end
    return list_voted_poll
  end

  #check another staff is managed
  def is_managing(id)
    if(id != 0 && id != nil)
      staff = Staff.find(id)
      if(staff)
        return Staff.get_staff_in_branch(self.id).include?(staff)
      end
    end
    return false
  end

  #get all staff are managed by this staff
  def get_branch
    staffs = Staff.where(:manager_id => self.id)
    list_staff_in_branch = staffs
    if list_staff_in_branch.size == 0
      puts "size = 0"
      return list_staff_in_branch
    else
      if Staff.max_manager_level(staffs) == 1
        return list_staff_in_branch
      else
        list_staff_in_branch.push(Staff.get_all_staff_from_list(staffs))
        return list_staff_in_branch
      end
    end

  end

  private
  # def validate_domain
  #   self.email.split("@")
  # end

  def self.get_all_staff_from_list(staffs)
    list_staff_in_branch = Array.new
    staffs.each do |staff|
      list_staff_in_branch.push(staff.get_branch)
    end
    # puts "list #{list_staff_in_branch.size}"
    return list_staff_in_branch
  end

  # get max manager_level of array staff
  def self.max_manager_level(staffs)
    max_manager_level = 0
    staffs.each do |staff|
      staff_level = staff.get_manager_level
      if max_manager_level < staff_level
        max_manager_level = staff_level
      end
    end
    return max_manager_level
  end

  #get sum_score of array staff
  def self.get_sum_score(staffs)
    sum_score = 0
    staffs.each do |staff|
      sum_score += staff.get_score
    end
    return sum_score
  end
end
