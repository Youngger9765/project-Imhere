class Admin::LotteriesController < ApplicationController

  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_lottery, :only => [:show, :edit, :update, :destroy, :users_list, :winners_list, :shipment]

  def index
    if params[:filter] == 'has_winner'
      @lotteries = Lottery.where(:got_winner => 1)

    elsif params[:filter] == 'overtime_no_winner'
      @lotteries = Lottery.where(:got_winner => 0).where('end_time < ?',Time.now)

    elsif params[:filter] == 'standby'
      @lotteries = Lottery.where(:got_winner => 0).where('end_time > ?',Time.now)

    elsif params[:filter] == 'setting_uncomplete'
      @lotteries = Lottery.where(:win_people => nil)

    else
      @lotteries = Lottery.all.order('end_time DESC')
      
    end
    
  end

  def new
    @lottery = Lottery.new
  end

  def create
    @lottery = @activity.lotteries.new(lottery_params)

    if @lottery.save
      flash[:notice] = "抽獎建立成功!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = @lottery.errors.messages
      render :new
    end
  end

  def edit
  end

  def update
    if @lottery.update(lottery_params)
      if params[:destroy_logo] == "1"
        @lottery.logo = nil
        @lottery.save!
      end

      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = @lottery.errors.messages
      render :edit
    end

    

    
  end

  def destroy
    @lottery.destroy!

    redirect_to admin_lotteries_path
  end

  def users_list
    if params[:filter] == 'get_winner'
      @lottery.get_winner
    end

    @users = @lottery.users.all
  end

  def winners_list
    if params[:filter] == 'refresh'
      @lottery.refresh_winner

    elsif params[:filter] == 'clean'
      @lottery.clean_winner
    end

    @winners = @lottery.users.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1})
  end

  def shipment
    if params[:shipment] == 'shipping'
      @lottery.fulfillment_status = "fulfilled"
      @lottery.save

    elsif params[:shipment] == 'cancel'
      @lottery.fulfillment_status = nil
      @lottery.save
    end

    redirect_to admin_lotteries_path
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :content, :start_time, 
                                    :end_time, :logo, :status,
                                    :win_people, :description, 
                                    :fulfillment_status,:fan_page_url,
                                    :fan_page_name, :push_time, :url
                                    )
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
  