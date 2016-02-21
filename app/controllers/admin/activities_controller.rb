class Admin::ActivitiesController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:show, :edit, :update, :destroy]

  def index
    @activities = Activity.all
    authorize @activities

    if params[:activity_id]
      @activity = Activity.find( params[:activity_id] )
    else
      @activity = Activity.new
    end
  end

  def show
    authorize @activity
    @milestones = @activity.activity_milestones.order("people ASC")
    @lotteries = @activity.lotteries
    @merchants = @activity.merchants
  end


  def create
    authorize @activity
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
    authorize @activity
  end

  def edit
    authorize @activity
  end

  def update
    authorize @activity
    @activity.update(activity_params)

    if params[:destroy_logo_in_event] == "1"
      @activity.logo_in_event = nil
      @activity.save!
    end

    if params[:destroy_banner] == "1"
      @activity.banner = nil
      @activity.save!
    end
    
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
    authorize @activity
    @activity.destroy

    redirect_to admin_event_activities_path(@event)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :content, :start_time, :end_time, 
                                     :logo, :participator, :location, :fund,
                                     :status, :information_picture, :information,
                                     :description, :logo_in_event, :banner
                                     )
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end

end
