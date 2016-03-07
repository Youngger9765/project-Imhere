class Admin::PrizesController < ApplicationController

  layout "admin"
  before_action :find_event, :only =>[:index,:new, :create]
  before_action :find_activity, :only =>[:index,:new, :create]
  before_action :find_lottery, :only => [:index,:new, :create, :edit, :update, :destroy]

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
        redirect_to admin_event_activity_lottery_prizes_path(@event,@activity,@lottery)
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
    
  end

  def destroy
    
  end


  private

  def prize_params
    params.require(:prize).permit(:name, :content)
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


end
