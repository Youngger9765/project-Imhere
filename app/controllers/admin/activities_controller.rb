class Admin::ActivitiesController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:show, :edit, :update, :destroy]

  def index
    @activities = Activity.all

    if params[:activity_id]
      @activity = Activity.find( params[:activity_id] )
    else
      @activity = Activity.new
    end
  end

  def show
    @milestones = @activity.activity_milestones.order("people ASC")
  end


  def create
    @activity = @event.activities.new(activity_params)

    if @activity.save
      flash[:notice] = "Create Success!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = "Create fail!"
      render :back
    end
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def update
    @activity.update(activity_params)
    
    if params[:destroy_logo] == "1"
      @activity.logo = nil
      @activity.save!
    end

    if params[:destroy_information_picture] == "1"
      @activity.information_picture = nil
      @activity.save!
    end

    redirect_to admin_event_activity_path(@event,@activity)
  end

  def destroy
    @activity.destroy

    redirect_to admin_event_activities_path(@event)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :content, :start_time, :end_time, 
                                     :logo, :participator, :location, :fund,
                                     :status, :information_picture, :information
                                     )
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end

end
