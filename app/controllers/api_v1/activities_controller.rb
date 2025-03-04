class ApiV1::ActivitiesController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    @activiies = @event.activities.all
  end

  def show
    if params[:auth_token]
      @user = User.find_by(:authentication_token => params[:auth_token])
      @favoriting_count = @user.activities.where(:id => params[:id]).count()
      if @user.user_activity_favoritings.find_by(:activity_id => params[:id])
        @favoriting = @user.user_activity_favoritings.find_by(:activity_id => params[:id])
        @favoriting.last_view_time = Time.now
        @favoriting.save!
      end
    end
    
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @milestones = @activity.activity_milestones.order("people ASC")
    @merchants = @activity.merchants
    @public_lotteries = @activity.lotteries.where('status = ?', 1)
    @public_availible_lotteries = @public_lotteries.where('push_time < ? AND end_time > ?', Time.now, Time.now)
    @milestone_logo_content = @activity.milestone_logo_content
    @achievement = @activity.get_achievement
    @artists = @activity.artists
  end

end
