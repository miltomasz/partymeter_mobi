class CommentsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build
  end

  def create
    @event = Event.find(params[:comment][:event_id])
    @comment = @event.comments.build({ author: params[:comment][:author], 
                                       content: params[:comment][:content] })

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to city_club_path(@event.club.city, @event.club)
    else
      render 'new'
    end
  end
end