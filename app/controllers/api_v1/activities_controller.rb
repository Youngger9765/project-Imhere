class ApiV1::ActivitiesController < ApplicationController

  def index
    @activiies = @event.activities.all
  end

  def show
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @milestones = @activity.activity_milestones.order("people ASC")
    @merchants = @activity.merchants
    @lotteries = @activity.lotteries
    @milestone_logo_content = @activity.milestone_logo_content

    @customers_target = @activity.customers_target
    @merchant_people_count = 10  # 之後靠order 
    @lottery_people_count = @activity.lotteries.sum(:users_count)
    
    if @customers_target && @customers_target > 0
      @achievement = (@lottery_people_count.to_f + @merchant_people_count.to_f)*100 / @customers_target.to_f
      @achievement = @achievement.to_i
    else
      @achievement = "目標尚未設定或設定錯誤"
    end
  end

end
