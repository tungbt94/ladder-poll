class Staff < ActiveRecord::Base
  #before_save { self.email = email.downcase }
  #validates :name, presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 255 },
                    #format: { with: VALID_EMAIL_REGEX },
                    #uniqueness: { case_sensitive: false }
   	def self.from_omniauth(auth)
		  where(provider: auth.provider, uid: auth.uid).first_or_initialize do |staff|
	      staff.provider = auth.provider
	      staff.uid = auth.uid
	      staff.name = auth.info.name
	      staff.oauth_token = auth.credentials.token
	      staff.save!
	  	end
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
end
