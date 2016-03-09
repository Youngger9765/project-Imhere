class Admin::MerchantsController < ApplicationController
  
  layout "admin"
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_merchant, :only => [:show, :edit, :update, :destroy]

  def index
    if params[:activity_id]
      @index_params = "activity"
      @merchants = @activity.merchants
    else
      @merchants = Merchant.all.order("merchantable_type DESC")
    end

    authorize @merchants
  end

  def new
    @merchant = Merchant.new
    authorize @merchant
  end

  def create
    @merchant = @activity.merchants.new(merchant_params)
    authorize @merchant

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
    
    if @merchant.merchantable_type == nil && params[:merchant][:merchantable_type] == "Activity"
      @update_status = "assign_activity"
    end

    @merchant.update(merchant_params)

    if params[:destroy_logo] == "1"
      @merchant.logo = nil
      @merchant.save!
    end

    if @update_status == "assign_activity"
      @event = @merchant.merchantable.event
      @activity = @merchant.merchantable
      redirect_to edit_admin_event_activity_merchant_path(@event,@activity,@merchant)
    else
      redirect_to admin_event_activity_merchant_path(@event,@activity,@merchant)
    end
  end

  def destroy
    authorize @merchant
    @merchant.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end

  private

  def merchant_params
    params.require(:merchant).permit( :name, :content, 
                                      :price, :logo, :merchantable_type,
                                      :merchantable_id,
                                      specs_attributes: [:id, :name, :selection, :_destroy, 
                                      selections_attributes:[:id, :name, :_destroy ]
                                      ]
                                    )
  end

  def find_event
    if params[:event_id]
      @event = Event.find(params[:event_id])
    end
  end

  def find_activity
    if params[:activity_id]
      @activity = Activity.find(params[:activity_id])
    end
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
