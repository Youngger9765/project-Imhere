class ApiV1::EventsController < ApiController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @activities = @event.activities
  end
end
