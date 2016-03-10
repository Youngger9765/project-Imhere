class ApiV1::ActivitiesController < ApplicationController

  def index
    @activiies = @event.activities.all
  end

  def show
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @milestones = @activity.activity_milestones.order("people ASC")
    @merchants = @activity.merchants
    @public_lotteries = @activity.lotteries.where(:status => 1)
    @milestone_logo_content = @activity.milestone_logo_content
    @achievement = @activity.get_achievement
  end

end
