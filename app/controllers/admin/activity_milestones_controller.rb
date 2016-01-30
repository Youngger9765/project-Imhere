class Admin::ActivityMilestonesController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_milestone, :only => [:edit, :update, :destroy]

  def index
  end

  def new
    @milestone = ActivityMilestone.new
  end

  def create
    @milestone = @activity.activity_milestones.new(milestone_params)

    if @milestone.save
      flash[:notice] = "Milestone Create Success!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = "Milestone Create fail!"
      render :back
    end
  end 

  def edit
  end

  def update
    @milestone.update(milestone_params)

    redirect_to admin_event_activity_path(@event,@activity)
  end

  def destroy
    @milestone.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end


  private

  def milestone_params
    params.require(:activity_milestone).permit(:people, :content)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end

  def find_milestone
    @milestone = ActivityMilestone.find(params[:id])
  end

end
