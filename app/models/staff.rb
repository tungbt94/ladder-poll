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
end
