module ClubsHelper
	def gravatar_for(club, options = { size: 50 })
		size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/1?s=#{size}"
    image_tag(gravatar_url, alt: club.name, class: "gravatar")
  end

  def event_button?(event, current_date)
  	return true if event.nil? || (event.created_at.hour <= 6 && current_date.hour > 6)
  	false
  end
end



