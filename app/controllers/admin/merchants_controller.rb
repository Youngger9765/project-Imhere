class Admin::MerchantsController < ApplicationController
  
  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_merchant, :only => [:show, :edit, :update, :destroy]

  def index
    @merchants = @activity.merchants
    authorize @merchants
  end

  def new
    @merchant = Merchant.new
    authorize @merchant
  end

  def create
    authorize @merchant
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
    authorize @merchant
  end

  def edit
    authorize @merchant
  end

  def update
    authorize @merchant
    @merchant.update(merchant_params)

    if params[:destroy_logo] == "1"
      @merchant.logo = nil
      @merchant.save!
    end

    redirect_to admin_event_activity_merchant_path(@event,@activity,@merchant)
  end

  def destroy
    authorize @merchant
    @merchant.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end

  private

  def merchant_params
    params.require(:merchant).permit( :description, :name, :content, 
                                      :price, :logo,
                                      specs_attributes: [:id, :name, :selection, :_destroy, 
                                          selections_attributes:[:id, :name, :_destroy ]
                                      ]
                                    )
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
