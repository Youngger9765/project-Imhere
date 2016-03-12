class Admin::PrizesController < ApplicationController

  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_event, :only =>[:index,:show,:new, :create, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:show,:index,:new, :create, :edit, :update, :destroy]
  before_action :find_lottery, :only => [:show,:edit, :index,:new, :create, :update, :destroy]
  before_action :find_prize, :only =>[:show, :edit, :update, :destroy]

  def index
    if params[:lottery_id]
      @prizes = @lottery.prizes.all
    end
    
  end

  def new
    @prize = Prize.new
  end

  def create
    if params[:lottery_id]
      @prize = @lottery.prizes.new(prize_params)

      if @prize.save
        flash[:notice] = "Prize Create Success!"
        redirect_to admin_event_activity_lottery_prize_path(@event,@activity,@lottery,@prize)
      else
        flash[:alert] = "lottery Create fail!"
        render :back
      end
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    @prize.update(prize_params)
    if params[:destroy_logo] == "1"
      @prize.logo = nil
      @prize.save!
    end

    redirect_to admin_event_activity_lottery_prize_path(@event,@activity,@lottery,@prize)
    
  end

  def destroy
    @prize.destroy!
    redirect_to admin_event_activity_lottery_prizes_path(@event,@activity,@lottery)
  end


  private

  def prize_params
    params.require(:prize).permit(:name, :content, :price, :vendor, :quatity, :brand, :logo)
  end

  def find_event
    @event = Event.find_by_id(params[:event_id])
  end

  def find_activity
    @activity = Activity.find_by_id(params[:activity_id])
  end

  def find_lottery
    @lottery = Lottery.find_by_id(params[:lottery_id])
  end

  def find_prize
    @prize = Prize.find_by_id(params[:id])
  end


end
