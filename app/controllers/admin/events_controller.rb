class Admin::EventsController < ApplicationController

  def index
    @events = Event.all

    if params[:event_id]
      @event = event.find( params[:event_id] )
    else
      @event = Event.new
    end
  end

  def show
    @event = Event.find(params[:id])
    @activities = @event.activities
    
    if params[:activity_id]
      @activity = Activity.find( params[:activity_id] )
    else
      @activity = Activity.new
    end
  end


  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "Create Success!"
      redirect_to admin_events_path
    else
      flash[:alert] = "Create fail!"
      render admin_events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :content, :start_time, :end_time)
  end

end
