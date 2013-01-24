class CommentsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build
  end

  def create
    @event = Event.find(params[:comment][:event_id])

    author = params[:comment][:author]
    content = params[:comment][:content]

    @comment = @event.comments.build({ author: author, content: content })

    respond_to do |format|
      if @comment.save
        format.html { redirect_to city_club_path(@event.club.city, @event.club), notice: 'Comment added!' }
        format.json { render json: { :result => 'success',  :redirect => city_club_path(@event.club.city, @event.club) } }
      else
        format.html { render 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity, content_type: 'text/json' }
      end
    end

  end
end