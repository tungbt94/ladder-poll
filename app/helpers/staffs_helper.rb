module StaffsHelper
	 def gravatar_for(staff)
	    gravatar_id = Digest::MD5::hexdigest(staff.email.downcase)
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
	    image_tag(gravatar_url, alt: staff.name, class: "gravatar")
	 end
end
