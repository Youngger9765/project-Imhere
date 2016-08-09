class Admin::ArtistsController < ApplicationController
  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_event, :only =>[:index, :new, :create, :show, :edit, :update, :destroy, :remove_from_activity]
  before_action :find_activity, :only =>[:index, :new, :create, :show, :edit, :update, :destroy, :remove_from_activity]
  before_action :find_artist, :only => [:show, :edit, :update, :destroy, :remove_from_activity]

  def index
    @artists = Artist.all
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
      @ship = ActivityArtistShip.create(:activity => @activity, :artist => @artist)
      @ship.save!
      flash[:notice] = "藝人 Create Success!"
      redirect_to admin_event_activity_path(@event,@activity)
    else
      flash[:alert] = @artist.errors.messages
      render :new
    end
  end 

  def show
    authorize @artist
  end

  def edit
    if @activity
      @url = admin_event_activity_artist_path(@event, @activity, @artist)
    else
      @url = admin_artist_path(@artist)
    end

    authorize @artist
  end

  def update
    authorize @artist
    if @artist.update(artist_params)
      flash[:notice] = "Edit Success!"
      if params[:destroy_logo] == "1"
        @artist.logo = nil
      end
      
      if params[:activity_id]
        redirect_to admin_event_activity_artist_path(@event, @activity, @artist)
      else
        redirect_to admin_artist_path(@artist)
      end
    else
      flash[:alert] = @artist.errors.messages
      render :edit
    end
  end

  def destroy
    authorize @artist
    @artist.destroy!

    redirect_to admin_artists_path
  end

  def remove_from_activity
    authorize @artist
    @ship = ActivityArtistShip.find_by(:activity => @activity, :artist => @artist)
    @ship.destroy!

    redirect_to admin_event_activity_path(@event, @activity)
  end

  private

  def artist_params
    params.require(:artist).permit( :name, :fb_link, :youtube_link,:ig_link, 
                                    :webo_link, :logo,
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
