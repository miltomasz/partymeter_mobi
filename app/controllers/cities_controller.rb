class CitiesController < ApplicationController
	def show
    @city = City.find(params[:id])
    @clubs = @city.clubs.paginate(page: params[:page])
	end

  def new
  	@city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save
      flash[:success] = "City successfully added!"
      redirect_to @city
    else
      render 'new'
    end
  end
end
