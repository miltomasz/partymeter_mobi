module ClubsHelper
  NEW_EVENT_START = 6
  
	def gravatar_for(club, options = { size: 50 })
		size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/1?s=#{size}"
    image_tag(gravatar_url, alt: club.name, class: "gravatar")
  end

  def event_button?(event, current_date)
    if event.nil?
      return true
    end

    if current_date.yday - event.created_at.yday == 1
      if current_date.hour <= NEW_EVENT_START
        if event.created_at.hour <= NEW_EVENT_START
          return true
        else
          return false
        end
      else
        return true
      end
    end

    if current_date.yday == event.created_at.yday
      if event.created_at.hour <= NEW_EVENT_START && current_date.hour > NEW_EVENT_START
        return true
      end
    end

    if current_date.yday - event.created_at.yday > 1
      return true
    end

  	false
  end
end



