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
end