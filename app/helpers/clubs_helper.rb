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

    if current_date.year == event.created_at.year
      return SameYearCalc.new(current_date).calc(event)
    end

    if current_date.year > event.created_at.year
      return DifferentYearCalc.new(current_date).calc(event)
    end
  end

  class YearCalc
    def initialize(current_date)
      @current_date = current_date
    end
  end

  class SameYearCalc < YearCalc
    def calc(event)
      if @current_date.yday - event.created_at.yday == 1
        if @current_date.hour <= NEW_EVENT_START
          return event.created_at.hour <= NEW_EVENT_START ? true : false
        else
          return true
        end
      end

      if @current_date.yday == event.created_at.yday
        if event.created_at.hour <= NEW_EVENT_START && @current_date.hour > NEW_EVENT_START
          return true
        end
      end

      if @current_date.yday - event.created_at.yday > 1
        return true
      end

      false
    end
  end

  class DifferentYearCalc < YearCalc
    def calc(event)
      if yesterday?(event)
        if @current_date.hour <= NEW_EVENT_START
          return event.created_at.hour <= NEW_EVENT_START ? true : false
        end
      end
      true
    end

    private 
      def yesterday?(event)
        event_day = DateTime.new(event.created_at.year, event.created_at.month, event.created_at.day).to_time
        current_day = DateTime.new(@current_date.year, @current_date.month, @current_date.day).to_time
        current_day.yesterday == event_day
      end
  end
end



