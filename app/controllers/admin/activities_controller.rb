class Admin::ActivitiesController < ApplicationController

  layout "admin"
  before_action :authenticate_user!
  before_action :user_admin?
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:show, :edit, :update, :destroy]

  def index
    @activities = @event.activities
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
    @artists = @activity.artists

    activiy_artists_id = @activity.artists.pluck(:id)  
    @standby_artists = Artist.where.not(id: activiy_artists_id)

    @customers_target = @activity.customers_target
    @merchant_people_count = @activity.merchants.sum(:orders_count)
    @lottery_people_count = @activity.lotteries.sum(:users_count)
    
    if @customers_target && @customers_target > 0
      @achievement = (@lottery_people_count.to_f + @merchant_people_count.to_f)*100 / @customers_target.to_f
      @achievement = @achievement.to_i
    else
      @achievement = "目標尚未設定或設定錯誤"
    end
  end


  def create
    @activity = @event.activities.new(activity_params)
    authorize @activity

    if @activity.save
      flash[:notice] = "Create Success!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = "Create fail!"
      flash[:alert] = @activity.errors.messages
      render :new
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

    if @activity.update(activity_params)

      if params[:activity][:artist_id]
        @artist = Artist.find(params[:activity][:artist_id])
        @ship = ActivityArtistShip.all.create(:activity => @activity,
                                              :artist => @artist
                                            )
        @ship.save!
      end

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

      if params[:destroy_merchant_banner] == "1"
        @activity.merchant_banner = nil
        @activity.save!
      end
      redirect_to admin_event_activity_path(@event,@activity)

    else
      flash[:alert] = @activity.errors.messages
      render :edit
    end
  end

  def destroy
    authorize @activity
    flash[:notice] = "活動成功移至垃圾桶! 你仍有機會將他救它回來！"
    @activity.status = -1
    @activity.save

    if params[:rescue] && params[:rescue] == "1"
      flash[:notice] = "活動成功還原，暫放在下架！"
      @activity.status = 0
      @activity.save
    end

    redirect_to admin_event_activities_path(@event)
  end

  def index_all
    @activities = Activity.all
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :content, :start_time, :end_time, 
                                     :logo, :participator, :location, :fund,
                                     :status, :information_picture, :information,
                                     :description, :logo_in_event, :banner,
                                     :milestone_logo_content, :customers_target,
                                     :merchant_description, :merchant_banner,
                                     :subdomain, :star_wish_name,
                                     )
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end

end
