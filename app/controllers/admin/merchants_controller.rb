class Admin::MerchantsController < ApplicationController
  
  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_merchant, :only => [:show, :edit, :update, :destroy]

  def index
    @merchants = @activity.merchants
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = @activity.merchants.new(merchant_params)

    if @merchant.save
      flash[:notice] = "merchant Create Success!"
      redirect_to admin_event_activity_merchant_path(@event,@activity,@merchant)
    else
      flash[:alert] = "merchant Create fail!"
      render :back
    end
  end 

  def show
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)

    redirect_to admin_event_activity_merchant_path(@event,@activity,@merchant)
  end

  def destroy
    @merchant.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:description, :name, :content, :price)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
