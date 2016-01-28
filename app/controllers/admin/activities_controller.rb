class Admin::ActivitiesController < ApplicationController

  layout "admin"

  def index
    @activities = Activity.all

    if params[:activity_id]
      @activity = Activity.find( params[:activity_id] )
    else
      @activity = Activity.new
    end
  end

  def show
    @activity = Activity.find(params[:id])
  end


  def create
    @event = Event.find(params[:event_id])
    @activity = @event.activities.new(activity_params)

    if @activity.save
      flash[:notice] = "Create Success!"
      redirect_to :back
    else
      flash[:alert] = "Create fail!"
      render :back
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :content, :start_time, :end_time)
  end
end
