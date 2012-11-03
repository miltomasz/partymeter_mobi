class StaticPagesController < ApplicationController
  def home
  	@cities = City.paginate(page: params[:city_page], per_page: 10)
  end

  def help
  end

  def about
  end

  def contact
  end
end
