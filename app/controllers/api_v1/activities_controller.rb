class ApiV1::ActivitiesController < ApplicationController

  def index
    @activiies = @event.activities.all
  end

  def show
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @milestone = @activity.activity_milestones.order("people ASC")
  end

end
