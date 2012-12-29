class EventsController < ApplicationController
	def new
		@club = Club.find(params[:club_id])
		@event = Event.new
	end
  
  def create
  	@club = Club.find(params[:club_id])
  	@event = @club.events.build(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      redirect_to city_club_path(@club.city, @club)
    else
      render 'new'
    end
  end

  def show
  	@event = Event.find(params[:id])
  end

  def thumbup
    @event = Event.find(params[:id])
    vote(:yes, :thumbup, @event.thumbup)
  end

  def thumbdown
    @event = Event.find(params[:id])
    vote(:no, :thumbdown, @event.thumbdown)
  end

  private
    def vote(text, property, value = 0)
      value ||= 0
      if @event.update_attributes({ property => value += 1 })
        flash[:success] = "Voted #{text}!"
      else
        flash[:error] = "An error occured!"
      end
      redirect_to city_club_path(@event.club.city, @event.club)
    end
end