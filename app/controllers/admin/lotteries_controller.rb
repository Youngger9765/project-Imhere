class Admin::LotteriesController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_lottery, :only => [:edit, :update, :destroy]

  def new
    @lottery = Lottery.new
  end

  def create
    @lottery = @activity.lotteries.new(lottery_params)

    if @lottery.save
      flash[:notice] = "lottery Create Success!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = "lottery Create fail!"
      render :back
    end
  end

  def edit
  end

  def update
    @lottery.update(lottery_params)
    if params[:destroy_logo] == "1"
      @lottery.logo = nil
      @lottery.save!
    end

    redirect_to admin_event_activity_path(@event,@activity)
  end

  def destroy
    @lottery.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :content, :start_time, 
                                    :end_time, :logo)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end

  def find_lottery
    @lottery = Lottery.find(params[:id])
  end

end
  