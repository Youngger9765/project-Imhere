class Admin::EventsController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:show, :edit, :update, :destroy]
  before_action :authenticate_user! 

  def index
    @events = Event.all
    #authorize @events

    if params[:event_id]
      @event = event.find( params[:event_id] )
    else
      @event = Event.new
    end
  end

  def new
    @event = Event.new 
  end 

  def show
    authorize @event
    @public_activities = @event.activities.where(:status => 1)
    @hide_activities = @event.activities.where(:status => 0)

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
      redirect_to admin_event_path(@event)
    else
      flash[:alert] = "Create fail!"
      render admin_events_path
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    if params[:destroy_logo] == "1"
      @event.logo = nil
      @event.save!
    end

    redirect_to admin_event_path(@event)
  end

  def destroy
    @event.destroy

    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :banner, :content, :start_time, 
                                  :end_time,:logo
                                  )
  end

  def find_event
    @event = Event.find(params[:id]) 
  end 

end
