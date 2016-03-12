class Admin::LotteriesController < ApplicationController

  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_lottery, :only => [:edit, :update, :destroy, :users_list, :winners_list]

  def index
    @lotteries = Lottery.all
  end

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

  def users_list
    @users = @lottery.users.all
  end

  def winners_list
    @winners = @lottery.users.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1})
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :content, :start_time, 
                                    :end_time, :logo, :status,
                                    :win_people)
  end

  def find_event
    @event = Event.find_by_id(params[:event_id])
  end

  def find_activity
    @activity = Activity.find_by_id(params[:activity_id])
  end

  def find_lottery
    @lottery = Lottery.find_by_id(params[:id])
  end

end
  