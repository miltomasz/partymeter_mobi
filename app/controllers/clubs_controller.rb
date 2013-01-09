class ClubsController < ApplicationController
  def index
    @city = City.find(params[:city_id])
    @clubs = @city.clubs.paginate(page: params[:city_page], per_page: 10)
  end
  
	def new
    @city = City.find(params[:city_id])
		@club = Club.new
	end
	
  def create
    @city = City.find(params[:city_id])
    @club = @city.clubs.build(params[:club])
    if @club.save
      flash[:success] = "Club created!"
      redirect_to city_clubs_url(@city)
    else
      render 'new'
    end
  end

  def show
    @club = Club.find(params[:id])
    @events = @club.events.paginate(page: params[:page])
    @comments = @events.first.comments if @events.any?
  end

  def destroy
  end
end