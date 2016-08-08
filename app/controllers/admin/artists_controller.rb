class Admin::ArtistsController < ApplicationController
  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :find_artist, :only => [:show, :edit, :update, :destroy]

  def index
    authorize @artists
  end

  def new
    @artist = Artist.new
    authorize @artist
  end

  def create
    @artist = @activity.artists.new(artist_params)
    authorize @artist

    if @artist.save
      flash[:notice] = "藝人 Create Success!"
      redirect_to admin_event_activity_artist_path(@event,@activity,@artist)
    else
      flash[:alert] = "藝人 Create fail!"
      render :new
    end
  end 

  def show
    authorize @artist
  end

  def edit
    authorize @artist
  end

  def update
    authorize @artist
  end

  def destroy
    authorize @artist
    @artist.destroy!

    redirect_to admin_event_activity_path(@event,@activity)
  end

  private

  def artist_params
    params.require(:artist).permit( :name, :fb_link, :youtube_link,:ig_link, :webo_link,

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

  def find_artist
    @artist = Artist.find(params[:id])
  end
end
