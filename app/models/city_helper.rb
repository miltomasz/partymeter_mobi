module CityHelper
  def sorted_clubs
    clubs.sort! do |club1, club2|
      if club1.events.first.nil?
        club1.events.build(thumbup: 0)
        club1.events.first.created_at = Time.now
      end

      if club2.events.first.nil?
        club2.events.build(thumbup: 0)
        club2.events.first.created_at = Time.now
      end

      club1.events.first.thumbup ||= 0
      club2.events.first.thumbup ||= 0

      if event_time(club2) < 24.hours && event_time(club1) < 24.hours
        club2.events.first.thumbup <=> club1.events.first.thumbup
      else
        club2.events.first.created_at <=> club1.events.first.created_at
      end
    end
  end

  private

  def event_time(club)
  	Time.now - club.events.first.created_at
  end
end