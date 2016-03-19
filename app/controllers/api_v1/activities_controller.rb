class ApiV1::ActivitiesController < ApplicationController

  def index
    @activiies = @event.activities.all
  end

  def show
    if params[:auth_token]
      @user = User.find_by(:authentication_token => params[:auth_token])
    end
    
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @milestones = @activity.activity_milestones.order("people ASC")
    @merchants = @activity.merchants
    @public_lotteries = @activity.lotteries.where('status = ?', 1)
    @public_availible_lotteries = @public_lotteries.where('push_time < ? AND start_time > ?', Time.now, Time.now)
    @public_ongoing_lotteries = @public_lotteries.where('start_time < ? AND end_time > ?', Time.now, Time.now)
    @milestone_logo_content = @activity.milestone_logo_content
    @achievement = @activity.get_achievement
  end

end
