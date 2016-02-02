class ApiV1::MerchantsController < ApplicationController

  def show
    @event = Event.find(params[:event_id])
    @activity = Activity.find(params[:activity_id])
    @merchant = Merchant.find(params[:id])
  end
end
