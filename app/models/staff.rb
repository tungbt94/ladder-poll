class Staff < ActiveRecord::Base
  has_many :staff_poll
  before_save { if self.email.present?
  					self.email = email.downcase
  				end
				}
  validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@vccloud.vn/i

  LISTDOMAIN = ["vccloud.vn", "vcc.vn", "admicro.vn", "gmail.com"]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    allow_nil: true

  validate :email_domain_check

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "80x80>" },
                    default_url: "/default/user/avatar/:style/missing.png",
                    url: "/images/user/avatar/:style/:hash:extension",
                    path: ':rails_root/public:url'

  validates_attachment_presence :avatar

  validates_attachment_file_name :avatar, :matches => [/jpeg\Z/, /jpg\Z/, /png\Z/]

  do_not_validate_attachment_file_type :avatar

  # interpolate in paperclip
  Paperclip.interpolates :hash  do |staff, style|
    staff.instance.uid.downcase
  end

  Paperclip.interpolates :extension  do |staff, style|
    File.extname(staff.instance.attachment_file_name) || ".jpg" rescue ".jpg"
  end

  def self.from_omniauth(auth)
		staff = where(provider: auth.provider, uid: auth.uid).first
    staff = Staff.new if staff.nil?
    staff.provider = auth.provider
    staff.uid = auth.uid
    staff.name = auth.info.name
    staff.email = auth.info.email
    staff.oauth_token = auth.credentials.token
    staff.avatar = auth.info.image
    staff.save!
    return staff
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
    if(self.id != nil && id != 0 && id != nil)
      staff = Staff.find(id)
      if(staff)
        return get_branch.include?(staff)
      end
    end
    return false
  end

  #get all staff are managed by this staff
  def get_branch
    if self.id != nil
      staffs = Staff.get_staffs_managed_by(self.id)
      list_staff_in_branch = Array.new
      # make stack
      stack_staff_to_check = Array.new
      staffs.each do |staff|
        stack_staff_to_check.push(staff.id)
      end
      # get all staff
      while(stack_staff_to_check.size != 0) do
        staff_id = stack_staff_to_check.pop
        list_staff_in_branch.push(Staff.find(staff_id))
        list_staff_managed = Staff.get_staffs_managed_by(staff_id)
        if(list_staff_managed.size > 0)
          list_staff_managed.each do |staff|
            stack_staff_to_check.push(staff.id)
          end
        end
      end
      return list_staff_in_branch
    else
      return nil
    end
  end

  def self.exist(email)
    if Staff.where(:email => email)
      return true
    end
    return false
  end

  def self.get_id_by_email(email)
    return Staff.where(:email => email.downcase).select(:id).take
  end

  def voted?(option)
    return true if StaffPoll.where(
      :staff_id => self.id,
      :option_id => option.id
    ).first
    return false
  end

  def set_key_person(key_person)
    staff = Staff.find(self.id)
    staff.update!(:key_person => key_person)
  end

  def update_profile(manager_email)
    staff = Staff.find(self.id)
    manager_id = Staff.where(:email => manager_email).first.id
    staff.update!(
      :manager_id => manager_id,
      :actived => true
    )
  end

  def email_domain_check
    domain = self.email.split("@").last
    errors.add(:base, 'domain not exist') unless LISTDOMAIN.include?(domain)
    return true if LISTDOMAIN.include?(domain)
    return false
  end

  scope :get_staffs_managed_by, lambda {|id|
    where(["manager_id LIKE ?", "%#{id}%"])
  }

  private

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
