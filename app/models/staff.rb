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
		staff.update_attributes(actived: true)
	end

  # get manager_level of staff
  def get_manager_level
    @manager_level = 1
    staffs = Staff.where(:manager_id => self.id)
    if(staffs)
      @manager_level = Staff.max_manager_level(staffs) + 1
    end
    return @manager_level
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

  # get score of staff
  def get_score
    sum_score = 0
    staffs = Staff.where(:manager_id => self.id)
    if(staffs)
      sum_score = Staff.get_sum_score(staffs)
    end
    @score = get_manager_level + self.key_person + Math.log(sum_score + 1, Math::E)
  end

  #get sum_score of array staff
  def self.get_sum_score(staffs)
    sum_score = 0
    staffs.each do |staff|
      sum_score += staff.get_score
    end
    return sum_score
  end

  #get voted poll
  def get_voted_poll
  end
end
