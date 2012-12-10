module ClubsHelper
	def gravatar_for(club, options = { size: 50 })
		size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/1?s=#{size}"
    image_tag(gravatar_url, alt: club.name, class: "gravatar")
  end

  def event_button?(event, current_date)
    if event.nil?
      return true
    end

    if event.created_at.yday < current_date.yday
      if current_date.hour <= 6
        if event.created_at.hour <= 6
          return true
        else
          return false
        end
      end
      return true
    end

    if event.created_at.hour <= 6 && current_date.hour > 6
      return true
    end

  	false
  end
end



